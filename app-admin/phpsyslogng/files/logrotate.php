#!/usr/bin/php
<?php
// Copyright (C) 2005 Claus Lund, clauslund@gmail.com

echo "\nStarting logrotate\n";
echo date("Y-m-d H:i:s\n");

$APP_ROOT = '/data/www/localhost/htdocs/phpsyslogng';

include_once "$APP_ROOT/includes/common_funcs.php";
include_once "$APP_ROOT/config/config.php";

$dbLink = db_connect_syslog(DBADMIN, DBADMINPW);

echo "Dropping temp".DEFAULTLOGTABLE." if it exists ... ";
// Drop temp table if it exists
$query = "DROP TABLE IF EXISTS temp".DEFAULTLOGTABLE;
perform_query($query, $dbLink);
echo "ok.\n";

echo "Creating ".DEFAULTLOGTABLE." ... ";
// Create new table
$query = "SHOW CREATE TABLE ".DEFAULTLOGTABLE;
$result = perform_query($query, $dbLink);
echo "ok.\n";

$row = mysql_fetch_array($result);
$createQuery = $row[1];
$search = "CREATE TABLE `".DEFAULTLOGTABLE."`";
$replace = "CREATE TABLE `temp".DEFAULTLOGTABLE."`";
$createQuery = str_replace($search, $replace, $createQuery);
perform_query($createQuery, $dbLink);

$today = date("Ymd");

// Drop the merge table
if(defined('MERGELOGTABLE') && MERGELOGTABLE)
  {
   $query = "FLUSH TABLES";
   perform_query($query, $dbLink);

   echo "Dropping ".MERGELOGTABLE." if it exists ... ";
   $query = "DROP TABLE IF EXISTS ".MERGELOGTABLE;
   perform_query($query, $dbLink);
   echo "ok.\n";
  }

// Rename the two tables
echo "Renaming ".DEFAULTLOGTABLE." to ".DEFAULTLOGTABLE.$today." and temp".DEFAULTLOGTABLE." to ".DEFAULTLOGTABLE." ... ";
$query = "RENAME TABLE ".DBNAME.".".DEFAULTLOGTABLE." TO ".DBNAME.".".DEFAULTLOGTABLE.$today.", ".DBNAME.".temp".DEFAULTLOGTABLE." TO ".DBNAME.".".DEFAULTLOGTABLE;
perform_query($query, $dbLink);
echo "ok.\n";

echo "\nLog rotate ended successfully.\n";
echo "Now optimizing old logs.\n";
$query = "OPTIMIZE TABLE ".DBNAME.".".DEFAULTLOGTABLE.$today;
perform_query($query, $dbLink);

// Re-create the merge table
if(defined('MERGELOGTABLE') || defined('LOGROTATERETENTION'))
  {
   echo "Getting list of log tables.\n";
   $logTableArray = get_logtables($dbLink);
  }

if(defined('LOGROTATERETENTION') && LOGROTATERETENTION)
  {
   echo "Retention is in use, searching for tables to drop:";
   foreach($logTableArray as $value)
     {
      if(preg_match("/[0-9]+$/", $value))
        {
         // determine is datestamp is old enough
         $tableDate = strrev(substr(strrev($value), 0, 8));
         $cutoffDate = date("Ymd", mktime(0, 0, 0, date("m"), date("d")-LOGROTATERETENTION, date("Y")));

//          printf(" [cutoffDate: %s tableDate %s] ", $cutoffDate, (intval($cutoffDate) > intval($tableDate)) ? ">":"<=",  $tableDate);

         if(intval($cutoffDate) > intval($tableDate))
           {
            $query = "DROP TABLE ".$value;
            perform_query($query, $dbLink);
           }
         }
     }
  }

if(defined('MERGELOGTABLE') && MERGELOGTABLE)
  {
   echo "Creating merge table:\n";
   $query = "SHOW CREATE TABLE ".DEFAULTLOGTABLE;

   $result = perform_query($query, $dbLink);
   $row = mysql_fetch_array($result);
   $createQuery = $row[1];

   $oldStr = "CREATE TABLE `".DEFAULTLOGTABLE."`";
   $newStr = "CREATE TABLE `".MERGELOGTABLE."`";
   $createQuery = str_replace($oldStr, $newStr, $createQuery);

   $oldStr = "ENGINE=MyISAM";
   $newStr = "ENGINE=MRG_MyISAM";
   $createQuery = str_replace($oldStr, $newStr, $createQuery);
   $oldStr = "TYPE=MyISAM";
   $newStr = "ENGINE=MRG_MyISAM";
   $createQuery = str_replace($oldStr, $newStr, $createQuery);

   $createQuery = str_replace('PRIMARY KEY', 'INDEX', $createQuery);

   // Re-create the merge table data (after some stuff has been dropped above by cutoffDate
   if(defined('MERGELOGTABLE') || defined('LOGROTATERETENTION'))
   {
      echo "Getting list of log tables.\n";
      $logTableArray = get_logtables($dbLink);
   }

   $unionStr = " UNION=(";
   foreach($logTableArray as $value)
     {
      $unionStr = $unionStr.$value.", ";
     }
   $unionStr = rtrim($unionStr, ", ");
   $unionStr = $unionStr.")";

   $createQuery = $createQuery.$unionStr;

   $flushQuery = "FLUSH TABLES";
   perform_query($flushQuery, $dbLink);

   perform_query($createQuery, $dbLink);

   $flushQuery = "FLUSH TABLES";
   perform_query($flushQuery, $dbLink);

   echo "ok,\n";
  }

echo "\n".date("Y-m-d H:i:s")."\n";
echo "All done!\n";
?>
