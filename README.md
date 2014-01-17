#cgirest-nix
=====

This is a sample application that implements a RESTful API that is able to manage the cgroups of a server.

As specified on the [wfh.io selection task](https://www.wfh.io/jobs/379/) it supports:

- listing available cgroups
- listing the tasks (PIDs) for a given cgroup
- placing a process into a cgroup

##Getting Started

Please note that this is by no means a standalone package, in order to be able to use it you will need prior knowledge of the following technologies:

- [Nixos](https://nixos.org/)
- Nixops, an excellent primer can be found [here](http://zef.me/5981/deploying-a-simple-node-js-application-with-nixops)
- [PHP](http://php.net/)
- [Curl](http://curl.haxx.se/)

##Requirements

- a working Nixos development environment
- a working Virtualbox or Amazon EC2 instance

##Installation

Create a deployment (a virtualbox instance in this case):

`nixops create network.nix infrastructure-vbox.nix --name node-vbox2`

and then deploy it:

`nixops deploy -d node-vbox2`


##API Syntax







