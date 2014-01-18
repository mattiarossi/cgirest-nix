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

##Installation and usage

Create a deployment (a virtualbox instance in this case):

`nixops create network.nix infrastructure-vbox.nix --name node-vbox2`

and then deploy it:

`nixops deploy -d node-vbox2`

This will create, provision and run an instance that will have all the components necessary to test the application

Look up the ip address of the instance

```
Matt-Lion-M6400:cgirest-nix mattiarossi$ nixops info -d node-vbox2
Network name: node-vbox2
Network UUID: 3924ffee-7fc2-11e3-bf12-a96bb66a98e3
Network description: ApacheCGI
Nix expressions: /Volumes/M6400Lion/Users/mattiarossi/Code/nixos/cgirest-nix/network.nix /Volumes/M6400Lion/Users/mattiarossi/Code/nixos/cgirest-nix/infrastructure-vbox.nix

+-----------+-----------------+------------+-------------------------------------------------------+----------------+
| Name      |      Status     | Type       | Resource Id                                           | IP address     |
+-----------+-----------------+------------+-------------------------------------------------------+----------------+
| apachecgi | Up / Up-to-date | virtualbox | nixops-3924ffee-7fc2-11e3-bf12-a96bb66a98e3-apachecgi | 192.168.56.101 |
+-----------+-----------------+------------+-------------------------------------------------------+----------------+
```

and do a curl request to the url 

`http://<ip address>/rest/cgroups/`

In my case the ip address is 192.168.56.101 and this is a log of a curl request with no parameters that will return all the available cgroups and their associated tasks:

`curl -i -XGET "http://192.168.56.101/rest/cgroups/"`

```
HTTP/1.1 200 OK
Date: Fri, 17 Jan 2014 22:31:29 GMT
Server: Apache/2.2.26 (Unix) DAV/2
X-Powered-By: PHP/5.4.23
Transfer-Encoding: chunked
Content-Type: application/json

{
    "data": {
        "method": "GET",
        "path": "cgroups",
        "query": [

        ]
    },
    "action": "List all cgroups with associated tasks",
    "cgroups": {
        "blkio": [
            "1",
            "2",
            "3",
            "6",
            "7",
            "8",
            "9",
            "10",
            "75",
            "77",
            "78",
            "80",
            "225",
            "230",
            "231",
            "300",
            "305",
            "310",
            "341",
            "436",
            "497",
            "503",
            "509",
            "515",
            "521",
            "527",
            "533",
            "539",
            "549",
            "550",
            "646",
            "647",
            "1044",
            "1053",
            "1074",
            "1076",
            "1100",
            "1369",
            "4810",
            "20358",
            "20363",
            "20364",
            "20378",
            "20385",
            "20386",
            "20387",
            "20388",
            "20390",
            "20391",
            "20392",
            "20395",
            "20414",
            "20426",
            "20461",
            "20467",
            "20468",
            "20469",
            "20470",
            "20471",
            "20472",
            "20473",
            "20474",
            "20488",
            "20493",
            "20494",
            "20495",
            "20500",
            "20501",
            "20539",
            "20623",
            "20645",
            "20646",
            "20647",
            "20693"
        ],
        "freezer": [
            "1",
            "2",
            "3",
            "6",
            "7",
            "8",
            "9",
            "10",
            "75",
            "77",
            "78",
            "80",
            "225",
            "230",
            "231",
            "300",
            "305",
            "310",
            "341",
            "436",
            "497",
            "503",
            "509",
            "515",
            "521",
            "527",
            "533",
            "539",
            "549",
            "550",
            "646",
            "647",
            "1044",
            "1053",
            "1074",
            "1076",
            "1100",
            "1369",
            "4810",
            "20358",
            "20363",
            "20364",
            "20378",
            "20385",
            "20386",
            "20387",
            "20388",
            "20390",
            "20391",
            "20392",
            "20395",
            "20414",
            "20426",
            "20461",
            "20467",
            "20468",
            "20469",
            "20470",
            "20471",
            "20472",
            "20473",
            "20474",
            "20488",
            "20493",
            "20494",
            "20495",
            "20500",
            "20501",
            "20539",
            "20623",
            "20645",
            "20646",
            "20647",
            "20693"
        ],
        "devices": [
            "1",
            "2",
            "3",
            "6",
            "7",
            "8",
            "9",
            "10",
            "75",
            "77",
            "78",
            "80",
            "225",
            "230",
            "231",
            "300",
            "305",
            "310",
            "341",
            "436",
            "497",
            "503",
            "509",
            "515",
            "521",
            "527",
            "533",
            "539",
            "549",
            "550",
            "646",
            "647",
            "1044",
            "1053",
            "1074",
            "1076",
            "1100",
            "1369",
            "4810",
            "20358",
            "20363",
            "20364",
            "20378",
            "20385",
            "20386",
            "20387",
            "20388",
            "20390",
            "20391",
            "20392",
            "20395",
            "20414",
            "20426",
            "20461",
            "20467",
            "20468",
            "20469",
            "20470",
            "20471",
            "20472",
            "20473",
            "20474",
            "20488",
            "20493",
            "20494",
            "20495",
            "20500",
            "20501",
            "20539",
            "20623",
            "20645",
            "20646",
            "20647",
            "20693"
        ],
        "memory": [
            "1",
            "2",
            "3",
            "6",
            "7",
            "8",
            "9",
            "10",
            "75",
            "77",
            "78",
            "80",
            "225",
            "230",
            "231",
            "300",
            "305",
            "310",
            "341",
            "436",
            "497",
            "503",
            "509",
            "515",
            "521",
            "527",
            "533",
            "539",
            "549",
            "550",
            "646",
            "647",
            "1044",
            "1053",
            "1074",
            "1076",
            "1100",
            "1369",
            "4810",
            "20358",
            "20363",
            "20364",
            "20378",
            "20385",
            "20386",
            "20387",
            "20388",
            "20390",
            "20391",
            "20392",
            "20395",
            "20414",
            "20426",
            "20461",
            "20467",
            "20468",
            "20469",
            "20470",
            "20471",
            "20472",
            "20473",
            "20474",
            "20488",
            "20493",
            "20494",
            "20495",
            "20500",
            "20501",
            "20539",
            "20623",
            "20645",
            "20646",
            "20647",
            "20693"
        ],
        "cpu,cpuacct": [
            "1",
            "2",
            "3",
            "6",
            "7",
            "8",
            "9",
            "10",
            "75",
            "77",
            "78",
            "80",
            "225",
            "230",
            "231",
            "300",
            "305",
            "310",
            "341",
            "436",
            "497",
            "503",
            "509",
            "515",
            "521",
            "527",
            "533",
            "539",
            "549",
            "550",
            "646",
            "647",
            "1053",
            "1074",
            "1076",
            "4810",
            "20623"
        ],
        "cpu,cpuacct/system": [

        ],
        "cpu,cpuacct/system/acpid.service": [
            "20539"
        ],
        "cpu,cpuacct/system/nscd.service": [
            "20461",
            "20467",
            "20468",
            "20469",
            "20470",
            "20471",
            "20472",
            "20473",
            "20474"
        ],
        "cpu,cpuacct/system/ntpd.service": [
            "20426"
        ],
        "cpu,cpuacct/system/dbus.service": [
            "20414"
        ],
        "cpu,cpuacct/system/httpd.service": [
            "20488",
            "20493",
            "20494",
            "20495",
            "20500",
            "20501",
            "20645",
            "20646",
            "20647",
            "20693"
        ],
        "cpu,cpuacct/system/systemd-udevd.service": [
            "20378"
        ],
        "cpu,cpuacct/system/cron.service": [
            "20395"
        ],
        "cpu,cpuacct/system/virtualbox.service": [
            "20364",
            "20385",
            "20386",
            "20387",
            "20388",
            "20390",
            "20391",
            "20392"
        ],
        "cpu,cpuacct/system/systemd-logind.service": [
            "20363"
        ],
        "cpu,cpuacct/system/sshd.service": [
            "20358"
        ],
        "cpu,cpuacct/system/getty@.service": [

        ],
        "cpu,cpuacct/system/getty@.service/getty@tty1.service": [
            "1100"
        ],
        "cpu,cpuacct/system/dhcpcd.service": [
            "1369"
        ],
        "cpu,cpuacct/system/systemd-journald.service": [
            "1044"
        ],
        "cpuset": [
            "1",
            "2",
            "3",
            "6",
            "7",
            "8",
            "9",
            "10",
            "75",
            "77",
            "78",
            "80",
            "225",
            "230",
            "231",
            "300",
            "305",
            "310",
            "341",
            "436",
            "497",
            "503",
            "509",
            "515",
            "521",
            "527",
            "533",
            "539",
            "549",
            "550",
            "646",
            "647",
            "1044",
            "1053",
            "1074",
            "1076",
            "1100",
            "1369",
            "4810",
            "20358",
            "20363",
            "20364",
            "20378",
            "20385",
            "20386",
            "20387",
            "20388",
            "20390",
            "20391",
            "20392",
            "20395",
            "20414",
            "20426",
            "20461",
            "20467",
            "20468",
            "20469",
            "20470",
            "20471",
            "20472",
            "20473",
            "20474",
            "20488",
            "20493",
            "20494",
            "20495",
            "20500",
            "20501",
            "20539",
            "20623",
            "20645",
            "20646",
            "20647",
            "20693"
        ],
        "systemd": [
            "2",
            "3",
            "6",
            "7",
            "8",
            "9",
            "10",
            "75",
            "77",
            "78",
            "80",
            "225",
            "230",
            "231",
            "300",
            "305",
            "310",
            "341",
            "436",
            "497",
            "503",
            "509",
            "515",
            "521",
            "527",
            "533",
            "539",
            "549",
            "550",
            "646",
            "647",
            "1053",
            "1074",
            "1076",
            "4810",
            "20623"
        ],
        "systemd/machine": [

        ],
        "systemd/user": [

        ],
        "systemd/system": [
            "1"
        ],
        "systemd/system/acpid.service": [
            "20539"
        ],
        "systemd/system/nscd.service": [
            "20461",
            "20467",
            "20468",
            "20469",
            "20470",
            "20471",
            "20472",
            "20473",
            "20474"
        ],
        "systemd/system/ntpd.service": [
            "20426"
        ],
        "systemd/system/dbus.service": [
            "20395",
            "20414"
        ],
        "systemd/system/httpd.service": [
            "20488",
            "20493",
            "20494",
            "20495",
            "20500",
            "20501",
            "20645",
            "20646",
            "20647",
            "20693"
        ],
        "systemd/system/systemd-udevd.service": [
            "20378"
        ],
        "systemd/system/virtualbox.service": [
            "20364",
            "20385",
            "20386",
            "20387",
            "20388",
            "20390",
            "20391",
            "20392"
        ],
        "systemd/system/systemd-logind.service": [
            "20363"
        ],
        "systemd/system/sshd.service": [
            "20358"
        ],
        "systemd/system/getty@.service": [

        ],
        "systemd/system/getty@.service/getty@tty1.service": [
            "1100"
        ],
        "systemd/system/dhcpcd.service": [
            "1369"
        ],
        "systemd/system/systemd-journald.service": [
            "1044"
        ]
    }
}
```

we can also query the API for a specific cgroup:

`curl -i -X GET "http://192.168.56.101/rest/cgroups/?cgroup=systemd/system/virtualbox.service"`

```
HTTP/1.1 200 OK
Date: Fri, 17 Jan 2014 22:39:51 GMT
Server: Apache/2.2.26 (Unix) DAV/2
X-Powered-By: PHP/5.4.23
Transfer-Encoding: chunked
Content-Type: application/json

{
    "data": {
        "method": "GET",
        "path": "cgroups",
        "query": {
            "cgroup": "systemd/system/virtualbox.service"
        }
    },
    "action": "List cgroup systemd/system/virtualbox.service  with associated tasks",
    "cgroups": {
        "systemd/system/virtualbox.service": [
            "20364",
            "20385",
            "20386",
            "20387",
            "20388",
            "20390",
            "20391",
            "20392"
        ]
    }
}
```

and we can also assign a task to a specific cgroup:

```
curl -i -X  POST "http://192.168.56.101/rest/cgroups/" \
--data-binary '{"setTask":{"cgroup": "systemd/system/dhcpcd.service","task": "20395"}}'
```

```
HTTP/1.1 200 OK
Date: Fri, 17 Jan 2014 22:42:12 GMT
Server: Apache/2.2.26 (Unix) DAV/2
X-Powered-By: PHP/5.4.23
Transfer-Encoding: chunked
Content-Type: application/json

{
    "data": {
        "method": "POST",
        "path": "cgroups",
        "query": {
            "setTask": {
                "cgroup": "systemd/system/dhcpcd.service",
                "task": "20395"
            }
        }
    },
	"action": "Associate task to cgroup, params cgroup and task required!",
    "result": [
        "1369",
        "20395"
    ],
    "cmdOutput": "Exit code: 0 - Output:Assigning task 20395 to group /sys/fs/cgroup/systemd/system/dhcpcd.service\n..done"
}
```


##Additional info

The code consists of a generic php class that implements a generic REST api on top of which a custom handler has been defined in order to 
implement the requested features. The handler queries the cgroups file structure in order to retrieve the requested data, and uses a shell script to associate tasks with cgroups running it with sudo in order to be able to modify the cgroups file system.

The apache server has been configured to run php scripts using fastcgi and to rewrite URLs so that any string following the default uri part /rest/ is considered a parameter and fed to the php handler.







