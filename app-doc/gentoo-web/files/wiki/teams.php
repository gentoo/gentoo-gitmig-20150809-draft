<?php	include "functions.php";
	main_header();
	if     ( $team == 'system' ) {
		$team =     'System';
		$team_num = 2;
	} elseif ( $team == 'desktop' ) {
		$team =     'Desktop';
		$team_num = 3;
	} elseif ( $team == 'server' ) {
		$team =     'Server';
		$team_num = 4;
	} elseif ( $team == 'tools' ) {
		$team =     'Tools';
		$team_num = 5;
	} elseif ( $team == 'infrastructure' ) {
		$team =     'Infrastructure';
		$team_num = 6;
	} else {
		print '<p style="font-color:red;">Unknown team.</p>';
		main_footer();
		exit;
	}

	$result = mysql_query( "select summary,status from teams where gid=$team_num" );
	list( $summary, $status ) = mysql_fetch_array( $result );

	$unassigned = mysql_query( "select tid from todos where public=1 and team=$team_num" );
	$unassigned = mysql_num_rows( $unassigned );

	$outstanding = mysql_query( "select tid from todos where priority!=0 and team=$team_num" );
	$outstanding = mysql_num_rows( $outstanding );

	if ( $team_num != 6 ) {
	   $us = mysql_query( "select tid from todos where public=1 and branch=2 and team=$team_num" );
	   $us = mysql_num_rows( $us );

	   $os = mysql_query( "select tid from todos where priority!=0 and branch=2 and team=$team_num" );
	   $os = mysql_num_rows( $os );

	   $uu = mysql_query( "select tid from todos where public=1 and branch=3 and team=$team_num" );
	   $uu = mysql_num_rows( $uu );
      
	   $ou = mysql_query( "select tid from todos where priority!=1 and branch=3 and team=$team_num" );
	   $ou = mysql_num_rows( $ou );

	   $un = mysql_query( "select tid from todos where public=1 and branch=0 and team=$team_num" );
	   $un = mysql_num_rows( $un );

	   $on = mysql_query( "select tid from todos where priority!=1 and branch=0 and team=$team_num" );
	   $on = mysql_num_rows( $on );
	}
?>

<div style="float:right;margin:5px;" width=175>
	<table border=0 cellpadding=1 cellspacing=0 width=175 bgcolor="black"><tr><td>
	<table border=0 cellpadding=3 cellspacing=0 width="100%" bgcolor="white">
	<tr>
		<td colspan=2 bgcolor="black"><p style="font-weight:bold;color:white">Current Stats</p></td>
	</tr>
<?php if ( $team_num != 6 ) { ?>
	<tr>
		<td><a href="teamtasks.php?team=<?=$team_num;?>&q=us">Unassigned Stable:</a></td>
		<td><?=$us;?></td>
	</tr>
	<tr>
		<td><a href="teamtasks.php?team=<?=$team_num;?>&q=os">Outstanding Stable:</a></td>
		<td><?=$os;?></td>
	</tr>
	<tr>
		<td><a href="teamtasks.php?team=<?=$team_num;?>&q=uu">Unassigned Unstable:</a></td>
		<td><?=$uu;?></td>
	</tr>
	<tr>
		<td><a href="teamtasks.php?team=<?=$team_num;?>&q=ou">Outstanding Unstable:</a></td>
		<td><?=$ou;?></td>
	</tr>
	<tr>
		<td><a href="teamtasks.php?team=<?=$team_num;?>&q=un">Unassigned Neither:</a></td>
		<td><?=$un;?></td>
	</tr>
	<tr>
		<td><a href="teamtasks.php?team=<?=$team_num;?>&q=on">Outstanding Neither:</a></td>
		<td><?=$on;?><br></td>
	</tr>
	<tr>
		<td><a href="teamtasks.php?team=<?=$team_num;?>&q=u">Total Unassigned:</a></td>
		<td><?=$unassigned;?></td>
	</tr>
	<tr>
		<td><a href="teamtasks.php?team=<?=$team_num;?>&q=o">Total Outstanding:</a></td>
		<td><?=$outstanding;?></td>
	</tr>
	<?php } else { ?>
	<tr>
		<td><a href="teamtasks.php?team=<?=$team_num;?>&q=u">Total Unassigned:</a></td>
		<td><?=$unassigned;?></td>
	</tr>
	<tr>
		<td><a href="teamtasks.php?team=<?=$team_num;?>&q=o">Total Outstanding:</a></td>
		<td><?=$outstanding;?></td>
	</tr>
	<?php } ?>
	</table>
	</td></tr></table>
</div>

	
<p style="font-size:medium;font-weight:bold;"><?=$team;?> Team</p>
<p><b>Summary</b></p>
<p style="margin:0 5px 10px 10px;"><?=$summary;?></p>
<p><b>Status</b></p>
<p style="margin:0 5px 10px 10px;"><?=$status;?></p>

<p><b>Team Members</b></p>
<ul>
<?php
	$result = mysql_query( "select username,title,email,realname from users where team=$team_num" );
	while ( $dude = mysql_fetch_array($result) ) {
?>
	<li> <a href="mailto:<?=$dude['email'];?>"><?=$dude['realname'];?></a> (aka <?=$dude['username'];?>) - <?=$dude['title'];?>
<?php
	}
?>
</ul>
</p>

<?php main_footer(); ?>

