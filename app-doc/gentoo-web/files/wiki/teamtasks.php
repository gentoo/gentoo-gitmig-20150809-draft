<?php
	include "functions.php";

	main_header( "Team Tasks" );

	$teamname = team_num_name( $team );

if ( !$q || !$team ) {
	print '<p style="font-color:red;">You must access this page from a teams page.</p>';
	main_footer();
	exit;
}

if ( $action == 'grab_todo' && $tid ) { grabtodo( $tid ); }

if ( $team == 6 ) {
	if ( $q == 'u' ) {
		$result = mysql_query( "select * from todos where priority!=0 and public=1 and team=$team" );
		?><p style="font-size:medium;font-weight:bold;">Unassigned Tasks for <?=$teamname;?> Team</p><?php
	} elseif ( $q == 'o' ) {
		$result = mysql_query( "select * from todos where priority!=0 and team=$team" );
		?><p style="font-size:medium;font-weight:bold;">Outstanding Tasks for <?=$teamname;?> Team</p><?php
	}
} elseif ( $q == 'u' ) {
	$result = mysql_query( "select * from todos where public=1 and team=$team and priority!=0 order by priority desc" );
	?><p style="font-size:medium;font-weight:bold;">Unassigned Tasks for <?=$teamname;?> Team</p><?php
} elseif ( $q == 'o' ) {
	$result = mysql_query( "select * from todos where team=$team and priority!=0 order by priority desc" );
	?><p style="font-size:medium;font-weight:bold;">Outstanding Tasks for <?=$teamname;?> Team</p><?php
} elseif ( $q == 'us' ) {
	$result = mysql_query( "select * from todos where public=1 and branch=2 and team=$team and priority!=0 order by priority desc" );
	?><p style="font-size:medium;font-weight:bold;">Unassigned Stable Tasks for <?=$teamname;?> Team</p><?php
} elseif ( $q == 'os' ) {
	$result = mysql_query( "select * from todos where branch=2 and team=$team and priority!=0 order by priority desc" );
	?><p style="font-size:medium;font-weight:bold;">Outstanding Stable Tasks for <?=$teamname;?> Team</p><?php
} elseif ( $q == 'uu' ) {
	$result = mysql_query( "select * from todos where public=1 and branch=3 and team=$team and priority!=0 order by priority desc" );
	?><p style="font-size:medium;font-weight:bold;">Unassigned Unstable Tasks for <?=$teamname;?> Team</p><?php
} elseif ( $q == 'ou' ) {
	$result = mysql_query( "select * from todos where branch=3 and team=$team and priority!=0 order by priority desc" );
	?><p style="font-size:medium;font-weight:bold;">Outstanding Unstable Tasks for <?=$teamname;?> Team</p><?php
} elseif ( $q == 'un' ) {
	$result = mysql_query( "select * from todos where public=1 and branch=0 and team=$team and priority!=0 order by priority desc" );
	?><p style="font-size:medium;font-weight:bold;">Unassigned Tasks on Neither Branch for <?=$teamname;?> Team</p><?php
} elseif ( $q == 'on' ) {
	$result = mysql_query( "select * from todos where branch=0 and team=$team and priority!=0 order by priority desc" );
	?><p style="font-size:medium;font-weight:bold;">Outstanding Tasks on Neither Branch for <?=$teamname;?> Team</p><?php
} else {
	print '<p style="font-color:red;">You must access this page from a teams page.</p>';
	main_footer();
	exit;
}


while ( $todo = mysql_fetch_array($result) ) {
	print_todo( $todo['title'], $todo['tid'], $todo['owner'], $todo['date'], $todo['public'], $todo['priority'], $todo['longdesc'], $todo['team'], $todo['branch'], 'teamtasks.php?action=grab_todo&tid='.$todo['tid']."&team=$team&q=$q" );
}
	main_footer();
?>
