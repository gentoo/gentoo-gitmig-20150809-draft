<?php
include "functions.php";
main_header( 'Edit Team' );

if ( !$gid || !$uid ) {
	print '<p style="color:red;">You aren\'t logged in or you didn\t come to this page from the right link.</p>';
	main_footer();
	exit;
}

// check to make sure they're a leader.
$query = mysql_query( "select leader,gid from teams where gid=$gid" );
$row = mysql_fetch_array($query);
$leaders = explode( ',', $row['leader'] );
while ( $each = each($leaders) ) {
	if ( $each['value'] == $uid ) {
		$num = $row['gid'];
		$name = team_num_name( $row['gid'] );
		break;
	}
}
$admin = mysql_query( "select admin from users where uid=$uid" );
list( $admin ) = mysql_fetch_row( $admin );
if ( !($name || $admin) ) {
	print '<p style="color:red;">You aren\'t the leader of that team!</p>';
	main_footer();
	exit;
}

if ( $summary || $status ) {
	// they submitted
	$result = mysql_query( "update teams set summary='$summary',status='$status' where gid=$num" );
	print '<p style="color:red;">Change(s) committed.</p>';
}

$info = mysql_query( "select summary,status from teams where gid=$gid" );
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
<p><input type="hidden" name="gid" value="<?=$gid;?>"><input type="submit" value="Submit Changes"></p>
</form>

<?php
main_footer();
?>
