<?php
include "functions.php";
main_header( 'Edit Team' );

$query = mysql_query( "select leader,gid from teams" );
while ( $row = mysql_fetch_array($query) ) {
	if ( $row['leader'] == $uid ) {
		$num = $row['gid'];
		$name = team_num_name( $row['gid'] );
		break;
	}
}
if ( !$name ) {
	print '<p color="red">You aren\'t the leader of any teams!</p>';
	main_footer();
	exit;
}

if ( $summary || $status ) {
	// they submitted
	$result = mysql_query( "update teams set summary='$summary',status='$status' where gid=$num" );
	print '<p color="red">Change(s) committed.</p>';
}

$info = mysql_query( "select summary,status from teams where gid=$num" );
list( $summary, $status ) = mysql_fetch_row( $info );
?>

<p style="font-size:medium;font-weight:bold;"><?=$name;?> Team Edit</p>

<form action="teamedit.php" method="post">
<p>
	<b>Summary:</b><br>
	<textarea name="summary" rows=10 cols=60><?=$summary;?></textarea>
</p>
<p>
	<b>Status:</b><br>
	<textarea name="status" rows=10 cols=60><?=$status;?></textarea>
</p>
<p><input type="submit" value="Submit Changes"></p>
</form>

<?php
main_footer();
?>
