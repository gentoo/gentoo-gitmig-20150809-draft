<?
/********************************************************************
Copyright (c) 2003 Jason Sessler

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation files
(the "Software"), to deal in the Software without restriction,
including without limitation the rights to use, copy, modify, merge,
publish, distribute, sublicense, and/or sell copies of the Software,
and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
********************************************************************/

/********************************************************************
	Changelog:
	01/11/2004  -   Changed how the MIDAS version is loaded to variable.
	12/15/2003  -   Version was incorrect
	            -   Cleaned a few non-problematic typos
	            -   Added check for MySQL Support in PHP

	12/02/2003  -   Added set_time_limit()

	11/27/2003  -   Added on/off toggle for creating the
					inc/config/config.php file.

********************************************************************/

// Needed for sql statements. When updating large MIDAS DBs, the
// process takes a lot longer than the php default time_limit
@set_time_limit(0);

define(_DOC_ROOT, "../");
define("_APPNAME", "MIDAS WebView Installer");

include _DOC_ROOT . "inc/version.php";
include _DOC_ROOT . "lib/mysql.inc.php";
include _DOC_ROOT . "lib/html.inc.php";
include _DOC_ROOT . "themes/plain_blue.php";

include "install.inc.php";

printf("<HTML>\n");
printf("<HEAD>\n");
printf("<TITLE>%s %s</TITLE>\n", _APPNAME, _VERSION);
printf("</HEAD>\n");
printf("<LINK rel=stylesheet href='%s' type=text/css>\n", $color['css']);

printf("<BODY bgcolor=%s topmargin=10 leftmargin=10>\n", $color[3]);

$DIR      = _DOC_ROOT . "inc/config";
$IMGDIR   = _DOC_ROOT . "php-graph";
$CONFIG   = $DIR . "/config.php";
$TEMPLATE = $DIR . "/config.template";

if($_POST['LOC'] == "") {
	$info = null;
	$error = FALSE;

	if(@is_readable($CONFIG)) {
		$schk .= html_tag("TR",
			         html_tag("TD", "Site Config Exists", $color[0], "class=blacksmall align=left") .
					 html_tag("TD", "WARNING", $color[1], "class=blacksmall align=center"),
				 "", "");
	} else {
		$schk .= html_tag("TR",
			         html_tag("TD", "Site Config Exists", $color[0], "class=blacksmall align=left") .
					 html_tag("TD", "OK", $color[12], "class=blacksmall align=center"),
				 "", "");
	}

	if(@is_readable($TEMPLATE)) {
		$schk .= html_tag("TR",
			         html_tag("TD", "Site Config Template Exists", $color[0], "class=blacksmall align=left") .
					 html_tag("TD", "OK", $color[12], "class=blacksmall align=center"),
				 "", "");
	} else {
		$schk .= html_tag("TR",
			         html_tag("TD", "Site Config Template Exists", $color[0], "class=blacksmall align=left") .
					 html_tag("TD", "ERROR", $color[2], "class=blacksmall align=center"),
				 "", "");
		$error = TRUE;
	}

	if(@!is_writeable($DIR)) {
		$schk .= html_tag("TR",
			         html_tag("TD", "/inc/config directory is Writable", $color[0], "class=blacksmall align=left") .
					 html_tag("TD", "ERROR", $color[2], "class=blacksmall align=center"),
				 "", "");
		$error = TRUE;
	} else {
		$schk .= html_tag("TR",
			         html_tag("TD", "/inc/config directory is Writable", $color[0], "class=blacksmall align=left") .
					 html_tag("TD", "OK", $color[12], "class=blacksmall align=center"),
				 "", "");
	}

	if(@!is_writeable($IMGDIR)) {
		$schk .= html_tag("TR",
			         html_tag("TD", "/php-graph directory is Writable", $color[0], "class=blacksmall align=left") .
					 html_tag("TD", "ERROR", $color[2], "class=blacksmall align=center"),
				 "", "");
		$error = TRUE;
	} else {
		$schk .= html_tag("TR",
			         html_tag("TD", "/php-graph directory is Writable", $color[0], "class=blacksmall align=left") .
					 html_tag("TD", "OK", $color[12], "class=blacksmall align=center"),
				 "", "");
	}
	if(@!function_exists(mysql_connect)) {
		$schk .= html_tag("TR",
			         html_tag("TD", "PHP with MySQL support", $color[0], "class=blacksmall align=left") .
					 html_tag("TD", "ERROR", $color[2], "class=blacksmall align=center"),
				 "", "");
		$error = TRUE;
	} else {
		$schk .= html_tag("TR",
			         html_tag("TD", "PHP with MySQL support", $color[0], "class=blacksmall align=left") .
					 html_tag("TD", "OK", $color[12], "class=blacksmall align=center"),
				 "", "");
	}
	if(@!function_exists(imagepng)) {
		$schk .= html_tag("TR",
			         html_tag("TD", "PHP with GD+PNG support", $color[0], "class=blacksmall align=left") .
					 html_tag("TD", "WARNING", $color[1], "class=blacksmall align=center"),
				 "", "");
	} else {
		$schk .= html_tag("TR",
			         html_tag("TD", "PHP with GD+PNG support", $color[0], "class=blacksmall align=left") .
					 html_tag("TD", "OK", $color[12], "class=blacksmall align=center"),
				 "", "");
	}

	$conf = html_tag("TR",
	            html_tag("TD", "Absolute directory\n", $color[0], "class=blacksmall align=left") .
	            html_tag("TD", "<input type=textbox name=ABS_ROOT value='/var/www/localhost/htdocs/midas-nms' size=30>\n", $color[3], "class=blacksmall align=left"),
			"", "") .
			html_tag("TR",
	            html_tag("TD", "URL Directory\n", $color[0], "class=blacksmall align=left") .
	            html_tag("TD", "<input type=textbox name=DOC_ROOT value='/midas-nms' size=20>\n", $color[3], "class=blacksmall align=left"),
			"", "") .
			sprintf("<input type=hidden name=RRD_ROOT value='/php-graph'>\n") .
			html_tag("TR",
	            html_tag("TD", "PHP Graphics URL Location\n", $color[0], "class=blacksmall align=left") .
	            html_tag("TD", "/php-graph\n", $color[3], "class=blacksmall align=left"),
			"", "") .
			html_tag("TR",
	            html_tag("TD", "MySQL Server\n", $color[0], "class=blacksmall align=left") .
	            html_tag("TD", "<input type=textbox name=SERVER value='localhost' size=20>\n", $color[3], "class=blacksmall align=left"),
			"", "") .
			html_tag("TR",
	            html_tag("TD", "MySQL user\n", $color[0], "class=blacksmall align=left") .
	            html_tag("TD", "<input type=textbox name=USER value='root' size=15>\n", $color[3], "class=blacksmall align=left"),
			"", "") .
			html_tag("TR",
	            html_tag("TD", "MySQL passwd\n", $color[0], "class=blacksmall align=left") .
	            html_tag("TD", "<input type=password name=PASSWD value='' size=10>\n", $color[3], "class=blacksmall align=left"),
			"", "") .
			html_tag("TR",
	            html_tag("TD", "MySQL dB\n", $color[0], "class=blacksmall align=left") .
	            html_tag("TD", "<input type=textbox name=DB value='MIDAS2' size=15>\n", $color[3], "class=blacksmall align=left"),
			"", "") .
			html_tag("TR",
	            html_tag("TD", "MIDAS MySQL allowed hosts\n", $color[0], "class=blacksmall align=left") .
	            html_tag("TD", "<input type=textbox name='ALLOWED_HOSTS' value='localhost' size=25>\n", $color[3], "class=blacksmall align=left"),
			"", "") .
			html_tag("TR",
	            html_tag("TD", "MIDAS MySQL user\n", $color[0], "class=blacksmall align=left") .
	            html_tag("TD", "<input type=textbox name=MIDAS_USER value='midas' size=15>\n", $color[3], "class=blacksmall align=left"),
			"", "") .
			html_tag("TR",
	            html_tag("TD", "MIDAS MySQL passwd\n", $color[0], "class=blacksmall align=left") .
	            html_tag("TD", "<input type=textbox name=MIDAS_PASSWD value='password' size=10>\n", $color[3], "class=blacksmall align=left"),
			"", "") .
			html_tag("TR",
	            html_tag("TD", "MIDAS dB SQL file\n", $color[0], "class=blacksmall align=left") .
	            html_tag("TD", "<input type=textbox name=MIDAS_SQL value='/usr/share/midas-nms/sql/MIDAS.sql' size=55>\n", $color[3], "class=blacksmall align=left"),
			"", "") .
			html_tag("TR",
	            html_tag("TD", "SNORT Default Rules SQL file\n", $color[0], "class=blacksmall align=left") .
	            html_tag("TD", "<input type=textbox name=SNORT_SQL value='/usr/share/midas-nms/sql/DefaultSnortRules.sql' size=55>\n", $color[3], "class=blacksmall align=left"),
			"", "") .
			html_tag("TR",
	            html_tag("TD", "Create inc/config/config.php file\n", $color[0], "class=blacksmall align=left") .
	            html_tag("TD", "<input type=checkbox name=CREATE_CONFIG_FILE value='1' checked>\n", $color[3], "class=blacksmall align=center"),
			"", "") .
			html_tag("TR",
	            html_tag("TD", "Create MIDAS dB user\n", $color[0], "class=blacksmall align=left") .
	            html_tag("TD", "<input type=checkbox name=CREATE_MIDAS_USER value='1' checked>\n", $color[3], "class=blacksmall align=center"),
			"", "") .
			html_tag("TR",
	            html_tag("TD", "Install MIDAS SQL\n", $color[0], "class=blacksmall align=left") .
	            html_tag("TD", "<input type=checkbox name=INSTALL_MIDAS_SQL value='1' checked>\n", $color[3], "class=blacksmall align=center"),
			"", "") .
			html_tag("TR",
	            html_tag("TD", "Install SNORT Default Rules SQL file\n", $color[0], "class=blacksmall align=left") .
	            html_tag("TD", "<input type=checkbox name=INSTALL_SNORT_SQL value='1' checked>\n", $color[3], "class=blacksmall align=center"),
			"", "");

	$info = html_tag("TABLE",
			    html_tag("TR",
				    html_tag("TD", "<b>Site Configuration Sanity Checks</b>", $color[9], "colspan=2 class=blacksmall align=center"),
				"", "") .
				$schk,
            $color[10], "width=50% cellspacing=1 cellpadding=2") .
            "<br>" .
			((!$error) ?
			html_tag("TABLE",
			    html_tag("TR",
			        sprintf("<FORM method=post action='install.php'>\n") .
				    html_tag("TD", "<b>Site Configuration</b>", $color[9], "colspan=2 class=blacksmall align=center"),
				"", "") .
				$conf .
			    html_tag("TR",
				    html_tag("TD", "<input type=submit name=LOC value=INSTALL>\n", $color[3], "colspan=2 class=blacksmall align=center") .
				    sprintf("</FORM>\n"),
				"", ""),
			$color[10], "width=50% cellspacing=1 cellpadding=2") :
			"The above error(s) must be fixed before continuing!\n");
} else if($_POST['LOC'] == "INSTALL") {
	// Building /inc/config/config.php
	if($_POST['CREATE_CONFIG_FILE']) {
		if($tp = @fopen($TEMPLATE, "r")) {
			if($fp = @fopen($CONFIG, "w+")) {
				while(!@feof($tp)) {
					$line = @fgets($tp, 1024);
					$pattern = null;
					$replace = null;
					$x = 0;
					$sPOS = 0;
					$ePOS = 0;
					while(($sPOS = strpos($line, "$[", $ePOS)) !== FALSE) {
						if(($ePOS = strpos($line, "]$", $sPOS)) !== FALSE) {
							$pattern[$x] = substr($line, $sPOS, $ePOS-($sPOS-2));
							$replace[$x] = $_POST[str_replace(Array("$[", "]$"), Array("", ""), $pattern[$x])];
							$x++;
						} else {
							$ePOS = $sPOS;
						}
					}
					fputs($fp, str_replace($pattern, $replace, $line));
				}
				fclose($fp);
			} else {
				$inst = html_tag("TR",
				            html_tag("TD", "config.php created", $color[0], "class=blacksmall align=left") .
				            html_tag("TD", "ERROR", $color[2], "class=blacksmall align=center"),
						"", "");
			}
			fclose($tp);
			if(is_null($inst)) {
				$inst = html_tag("TR",
				            html_tag("TD", "config.php created", $color[0], "class=blacksmall align=left") .
				            html_tag("TD", "OK", $color[12], "class=blacksmall align=center"),
						"", "");
			}
		} else {
			$inst = html_tag("TR",
			            html_tag("TD", "config.php created", $color[0], "class=blacksmall align=left") .
			            html_tag("TD", "ERROR", $color[2], "class=blacksmall align=center"),
					"", "");
		}
	}
						
	// SQL install (If applicable)
	$credentials['mySQL']['server'] = $_POST['SERVER'];
	$credentials['mySQL']['user']   = $_POST['USER'];
	$credentials['mySQL']['passwd'] = $_POST['PASSWD'];
	$db = new conn_mySQL($credentials);

	$db->db_new_conn();

	if($_POST['CREATE_MIDAS_USER']) {
		$db->db = "mysql";
		$hostList = explode(",", $_POST['ALLOWED_HOSTS']);
		for($x=0;$x<sizeof($hostList);$x++) {
			$db->add_table("user");
			$db->add_data("Host", $hostList[$x]);
			$db->add_data("User", $_POST['MIDAS_USER']);
			$db->add_data("Password", sprintf("PASSWORD('%s')", $_POST['MIDAS_PASSWD']), FALSE);
			$ret = $db->compile_query("INSERT");
			if($ret['return']) {
				$db->run_query();
				$inst .= html_tag("TR",
				             html_tag("TD", sprintf("MIDAS User created (%s)", $hostList[$x]), $color[0], "class=blacksmall align=left") .
				             html_tag("TD", "OK", $color[12], "class=blacksmall align=center"),
						 "", "");
				$db->clear_res();

				$db->add_table("db");
				$db->add_data("Host", $hostList[$x]);
				$db->add_data("Db", $_POST['DB']);
				$db->add_data("User", $_POST['MIDAS_USER']);
				$db->add_data("Select_priv", "Y");
				$db->add_data("Insert_priv", "Y");
				$db->add_data("Update_priv", "Y");
				$db->add_data("Delete_priv", "Y");
				$db->add_data("Create_priv", "Y");
				$db->add_data("Drop_priv", "Y");
				$db->add_data("Grant_priv", "Y");
				$db->add_data("References_priv", "Y");
				$db->add_data("Index_priv", "Y");
				$db->add_data("Alter_priv", "Y");
				$ret = $db->compile_query("INSERT");
				if($ret['return']) {
					$db->run_query();
					$inst .= html_tag("TR",
					             html_tag("TD", sprintf("MIDAS User dB privileges (%s)", $hostList[$x]), $color[0], "class=blacksmall align=left") .
				             	 html_tag("TD", "OK", $color[12], "class=blacksmall align=center"),
							 "", "");
				} else {
					$inst .= html_tag("TR",
					             html_tag("TD", sprintf("MIDAS User dB privileges (%s)", $hostList[$x]), $color[0], "class=blacksmall align=left") .
				             	 html_tag("TD", "ERROR", $color[2], "class=blacksmall align=center"),
							 "", "");
				}
			} else {
				$inst .= html_tag("TR",
				             html_tag("TD", sprintf("MIDAS User created (%s)", $hostList[$x]), $color[0], "class=blacksmall align=left") .
				             html_tag("TD", "ERROR", $color[2], "class=blacksmall align=center"),
						 "", "");
			}
			$db->clear_res();
		}

		$db->db = null;
		$db->run_query("FLUSH PRIVILEGES");
		if($db->sqlResults) {
			$inst .= html_tag("TR",
			             html_tag("TD", "Flushing privileges", $color[0], "class=blacksmall align=left") .
			           	 html_tag("TD", "OK", $color[12], "class=blacksmall align=center"),
					 "", "");
		} else {
			$inst .= html_tag("TR",
			             html_tag("TD", "Flushing privileges", $color[0], "class=blacksmall align=left") .
			           	 html_tag("TD", "ERROR", $color[2], "class=blacksmall align=center"),
					 "", "");
		}
	}

	$db->clear_res();
	$db->db = null;

	if($_POST['INSTALL_MIDAS_SQL'] || $_POST['INSTALL_SNORT_SQL']) {
		$db->run_query(sprintf("CREATE DATABASE IF NOT EXISTS %s", $_POST['DB']));
		if($db->sqlResults) {
			$inst .= html_tag("TR",
			             html_tag("TD", "MIDAS dB created", $color[0], "class=blacksmall align=left") .
			             html_tag("TD", "OK", $color[12], "class=blacksmall align=center"),
					 "", "");
			$db->clear_res();
			if($_POST['INSTALL_MIDAS_SQL']) {
				if($SQL = parseSQL($_POST['MIDAS_SQL'])) {
					$ERROR = FALSE;
					$db->db = $_POST['DB'];
					@reset($SQL);
					while(!is_null($key = @key($SQL))) {
						$db->run_query($SQL[$key]);
						if(!$db->sqlResults) {
							$ERROR = TRUE;
						}
						@next($SQL);
					}
					if($ERROR) {
						$inst .= html_tag("TR",
						             html_tag("TD", "MIDAS SQL Import", $color[0], "class=blacksmall align=left") .
						             html_tag("TD", "ERROR", $color[2], "class=blacksmall align=center"),
								 "", "");
					} else {
						$inst .= html_tag("TR",
						             html_tag("TD", "MIDAS SQL Import", $color[0], "class=blacksmall align=left") .
						             html_tag("TD", "OK", $color[12], "class=blacksmall align=center"),
								 "", "");
					}
				} else {
					$inst .= html_tag("TR",
					             html_tag("TD", "MIDAS SQL Import", $color[0], "class=blacksmall align=left") .
					             html_tag("TD", "ERROR", $color[2], "class=blacksmall align=center"),
							 "", "");
				}
			}

			if($_POST['INSTALL_SNORT_SQL']) {
				if($SQL = parseSQL($_POST['SNORT_SQL'])) {
					$ERROR = FALSE;
					$db->db = $_POST['DB'];
					@reset($SQL);
					while(!is_null($key = @key($SQL))) {
						$db->run_query($SQL[$key]);
						if(!$db->sqlResults) {
							$ERROR = TRUE;
						}
						@next($SQL);
					}
					if($ERROR) {
						$inst .= html_tag("TR",
						             html_tag("TD", "SNORT SQL Import", $color[0], "class=blacksmall align=left") .
						             html_tag("TD", "ERROR", $color[2], "class=blacksmall align=center"),
								 "", "");
					} else {
						$inst .= html_tag("TR",
						             html_tag("TD", "SNORT SQL Import", $color[0], "class=blacksmall align=left") .
						             html_tag("TD", "OK", $color[12], "class=blacksmall align=center"),
								 "", "");
					}
				} else {
					$inst .= html_tag("TR",
					             html_tag("TD", "SNORT SQL Import", $color[0], "class=blacksmall align=left") .
					             html_tag("TD", "ERROR", $color[2], "class=blacksmall align=center"),
							 "", "");
				}
			}
		} else {
			$inst .= html_tag("TR",
			             html_tag("TD", "MIDAS dB created", $color[0], "class=blacksmall align=left") .
			             html_tag("TD", "ERROR", $color[2], "class=blacksmall align=center"),
					 "", "");
		}
	}

	$info = html_tag("TABLE",
	            html_tag("TR",
	                html_tag("TD", "<b>Site Installation Results</b>", $color[9], "colspan=2 class=blacksmall align=center"),
				"", "") .
				$inst .
				html_tag("TR",
				    html_tag("TD", sprintf("Click <A HREF='../index.php'>here</A> to access the logon screen\n"),
				        $color[12], "colspan=2 class=blacksmall align=center"),
				"", ""),
			$color[10], "width=50% cellspacing=1 cellpadding=1 align=center");
}

	echo html_tag("TABLE",
	        html_tag("TR",
	            html_tag("TD",
				sprintf("<SPAN class='titlelarge'>%s %s</SPAN><br><br>\n", _APPNAME, _VERSION), $color[4], "height=50 align=right valign=center"),
	        "", "") .
	        html_tag("TR",
	            html_tag("TD", $info, $color[12], "width=100% height=100% align=center valign=center"),
			"", ""),
	    $color[10], "width=100% height=100% align=center valign=center");

printf("</BODY>\n");
printf("</HTML>\n");
?>
