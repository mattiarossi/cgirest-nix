


{
  # Name of our deployment
  network.description = "ApacheCGI";
  # It consists of a single server named 'helloserver'
  apachecgi =
    # Every server gets passed a few arguments, including a reference
    # to nixpkgs (pkgs)
    { config, pkgs, ... }:
    let
      # make sure we always have the latest module
      #pkgs = import /nix/nixpkgs/nixpkgs-weber//pkgs/top-level/all-packages.nix;
      # We import our custom packages from ./default passing pkgs as argument
      packages = import ./default.nix { pkgs = pkgs; };
      # This is the nodejs version specified in default.nix
      nodejs   = packages.nodejs;
      # And this is the application we'd like to deploy
      cgiapp   = packages.cgiapp;
      apacheLogs       = "/data/log";
      "php54" = {
                  daemonCfg.id = "php54";
                  daemonCfg.php = pkgs.php5_4fpm;
                  daemonCfg.phpIniLines = ''
                  ping.path = /ping
                  zend_extension=${pkgs.php_opcache}/lib/php/extensions/opcache.so
                  opcache.enable=1
                  opcache.memory_consumption=128
                  opcache.interned_strings_buffer=8
                  opcache.max_accelerated_files=4000
                  opcache.revalidate_freq=60
                  opcache.fast_shutdown=1
                  opcache.enable_cli=1
                  '';
                  poolItemCfg = {
                      user = "nginx";
                      group = "nginx";
                      listen = { owner = config.services.nginx.user; group = config.services.nginx.group; mode = "0700"; };
                      slowlog = "/srv/php/slowlog";
                  };
      };


    in
    {

      # Enable Firewall
      networking.firewall.enable = true;
      networking.firewall.allowedTCPPorts = [ 80 22 ];
      networking.firewall.allowPing = true;


      # Disable sudo
      security.sudo.enable = true;

      security.sudo.configFile = ''
          # Don't edit this file. Set the NixOS option â€˜security.sudo.configFileâ€™ instead.

          # Environment variables to keep for root and %wheel. test
          Defaults:root,%wheel env_keep+=LOCALE_ARCHIVE
          Defaults:root,%wheel env_keep+=NIX_PATH
          Defaults:root,%wheel env_keep+=TERMINFO_DIRS

          # Keep SSH_AUTH_SOCK so that pam_ssh_agent_auth.so can do its magic.
          Defaults env_keep+=SSH_AUTH_SOCK

          # "root" is allowed to do anything.
          root        ALL=(ALL) SETENV: ALL

          # Users in the "wheel" group can do anything.
          %wheel      ALL=(ALL) SETENV: ALL
          wwwrun      ALL= NOPASSWD: ${cgiapp}/scripts/setCgroupTask.sh
        '';


      # Apache configuration
      services.httpd = {
        enable = true;
        adminAddr = "mattia.rossi@gmail.com";

        # We'll set the wordpress package as our document root
        documentRoot = "${cgiapp}/app";

        # Let's store our logs in the volume as well
        logDir = apacheLogs;

        # And enable the PHP5 apache module
        #extraModules = [ { name = "php5"; path = "${pkgs.php}/modules/libphp5.so"; } ];

        # And some extra config to make things work nicely
        extraConfig = ''
            <Directory "/var/www">
              DirectoryIndex index.php
              Allow from *
              Options FollowSymLinks
              AllowOverride All
            </Directory>
            ScriptAlias /phpcgi/ ${pkgs.php54}/bin/
            AddHandler application/x-httpd-php5 php
            Action application/x-httpd-php5 /phpcgi/php-cgi
            <Directory "${cgiapp}/app/rest">
              RewriteEngine On
              ReWriteBase /rest/
              RewriteCond %{REQUEST_FILENAME} !-F
              RewriteRule ^(.*)$ r.php?%{QUERY_STRING} [L]
            </Directory>


        '';
      };


      # And lastly we ensure the user we run our project as is created
      users.extraUsers = {
        nodejs = { };
      };
    };
}
