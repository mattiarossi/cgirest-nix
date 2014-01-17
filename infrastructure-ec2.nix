let
  # Insert your access key here
  accessKey = "AKIAIDH5KQBFE34FHF2Q";
in {
  # Mapping of our 'helloserver' machine
  apachecgi = { resources, ... }:
    { deployment.targetEnv = "ec2";
      # We'll be deploying a micro instance to Virginia
      deployment.ec2.region = "eu-west-1";
      deployment.ec2.instanceType = "t1.micro";
      deployment.ec2.accessKeyId = accessKey;
      # We'll let NixOps generate a keypair automatically
      deployment.ec2.keyPair = resources.ec2KeyPairs.helloapp-kp.name;
      # This should be the security group we just created
      deployment.ec2.securityGroups = [ "mat-test" ];
    };

  # Here we create a keypair in the same region as our deployment
  resources.ec2KeyPairs.helloapp-kp = {
    region = "eu-west-1";
    accessKeyId = accessKey;
  };
}
