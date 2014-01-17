<?php
require("serviceREST.php");

class cgroups {

	var $baseDir;
	var $setCgroupsPath;

	function __construct(){
		$this->baseDir        = '/sys/fs/cgroup';
		$this->setCgroupsPath = '../../scripts/setCgroupTask.sh';
	}

	public function run($data){
	   	$res         = array("data"=>$data);
	   	$statuscode  = 404;
	   	$localGroups = $this->getCgroups();
	   	switch(strtoupper($data['method'])){
				case 'GET':
					if ($data['query']['cgroup'] === null){
						// Default action with no parameters, show all cgroups and tasks
						$res["action"]  = "List all cgroups with associated tasks";
						$res["cgroups"] = $localGroups;
					}else{
						$cgroup = $data['query']['cgroup'];
						$res["action"]  = "List cgroup $cgroup  with associated tasks";
						$res["cgroups"] = array( $cgroup => $localGroups[$cgroup]);
					}
					$statuscode = 200;
					break;
				case 'POST':
					$res["action"] = "Associate task to cgroup, params cgroup and task required!";
					$res["result"] = "";
					if ($data['query']['setTask'] === null){
						$res["result"] = "Error - wrong input format";
						$statuscode    = 400;
					}else{
						$cgroup = $data['query']['setTask']['cgroup'];
						$task   = $data['query']['setTask']['task'];
						if ($cgroup === null || $task===null){
							$res["result"] = "Error - parameters cgroup and task have to be provided";
						}else{
							if ($localGroups[$cgroup] === null){
								$res["result"] = "Error - cgroup $cgroup does not exist";
							}else{
								exec("/var/setuid-wrappers/sudo ".$this->setCgroupsPath." $cgroup $task 2>&1", $setCgroups, $result);
								$res["result"] = array($cgroup, $this->getCgroups()[$cgroup]);
								$res["cmdOutput"] = "Exit code: " .$result." - Output:".implode("\n",$setCgroups);
								if ($result != 0){
									$res["result"] = "Error while executing the setCgroups script, exit code: $result";
									$statuscode    = 400;
								}else{
									$res["result"] = $this->getCgroups()[$cgroup];
									$statuscode    = 200;
								}
							}
						}

					}
					break;
				default:
					$res["method"] = $data['method'];
					$res["action"] = "Not Supported";
					$statuscode    = 405;
					break;
		}

	   	return array(
			'statusCode' => $statuscode,
			'data'       => $res,
			'type'       => null);


	}

	private function getCgroups(){
		$dir  = new RecursiveDirectoryIterator($this->baseDir);
		$dirs = array();
		$iter = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($this->baseDir));
		foreach($iter as $file) {
		    if ($file->getFilename() == '.') {
		    	if ($file->getPath() != $this->baseDir){
			    	$dirs[substr($file->getPath(),strlen($this->baseDir)+1)] = array_filter(explode( "\n", file_get_contents( $file->getPath()."/tasks")));
		    	}
		    }
		}
		return $dirs;
	}
}

$c = new serverREST();
$c->addObject("cgroups","cgroups");
$c->execServer();
?>
