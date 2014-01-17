


{
  # Name of our deployment
  network.description = "ApacheCGI";
  # It consists of a single server named 'apachecgi'
  apachecgi =
    # Every server gets passed a few arguments, including a reference
    # to nixpkgs (pkgs)
    { config, pkgs, ... }:
    let
      # We import our custom packages from ./default passing pkgs as argument
      packages = import ./default.nix { pkgs = pkgs; };
      # This is the nodejs version specified in default.nix
      nodejs   = packages.nodejs;
      # And this is the application we'd like to deploy
      cgiapp   = packages.cgiapp;
      apacheLogs       = "/data/log";

    in
    {

      # Enable Firewall
      networking.firewall.enable = true;
      networking.firewall.allowedTCPPorts = [ 80 22 ];
      networking.firewall.allowPing = true;


      # Enable sudo
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

        # And some extra config to make things work nicely
        extraConfig = ''
            <Directory "${cgiapp}/app/">
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
