<?php	include "functions.php";
	main_header();
	$team_num = $team;
	$team = $teams[$team];
	if (!$team) {
		print '<p style="color:red;">Unknown team.</p>';
		main_footer();
		exit;
	}

	$result = mysql_query( "select summary,status,leader from teams where gid=$team_num" );
	list( $summary, $status, $leader ) = mysql_fetch_array( $result );

	// are we a leader?
	$leaders = explode( ',', $leader );
	$leader = 0;
	while ( $each = each($leaders) ) {
		if ( $each['value'] == $uid && $uid ) {
			$leader = 1;
			break;
		}
	}

	// query for stats
	$unassigned = mysql_query( "select tid from todos where public=1 and team=$team_num and priority!=0" );
	$unassigned = mysql_num_rows( $unassigned );

	$outstanding = mysql_query( "select tid from todos where priority!=0 and team=$team_num" );
	$outstanding = mysql_num_rows( $outstanding );

	if ( $team_num != 6 ) {
	   $us = mysql_query( "select tid from todos where public=1 and branch=2 and team=$team_num and priority!=0" );
	   $us = mysql_num_rows( $us );

	   $os = mysql_query( "select tid from todos where branch=2 and team=$team_num and priority!=0" );
	   $os = mysql_num_rows( $os );

	   $uu = mysql_query( "select tid from todos where public=1 and branch=3 and team=$team_num and priority!=0" );
	   $uu = mysql_num_rows( $uu );
      
	   $ou = mysql_query( "select tid from todos where branch=3 and team=$team_num and priority!=0" );
	   $ou = mysql_num_rows( $ou );

	   $un = mysql_query( "select tid from todos where public=1 and branch=0 and team=$team_num and priority!=0" );
	   $un = mysql_num_rows( $un );

	   $on = mysql_query( "select tid from todos where branch=0 and team=$team_num and priority!= 0" );
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
		<td><?=$on;?></td>
	</tr>
	<tr>
		<td colspan=2>&nbsp;</td>
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
	<br>
	<table border=0 cellpadding=1 cellspacing=0 width=175 bgcolor="black"><tr><td>
	<table border=0 cellpadding=3 cellspacing=0 width="100%" bgcolor="white">
	<tr>
		<td colspan=2 bgcolor="black"><p style="font-weight:bold;color:white">Group Leaders</p></td>
	</tr>
	<tr>
		<td>
	<?php
	reset( $leaders );
	$tmp = 0;
	while ( $each = each($leaders) ) {
		if (!$each['value']) break; //seems to want to always loop at least once. *shrug*
		$handle = mysql_query( 'select username,email from users where uid='.$each['value'] );
		list( $handle, $email ) = mysql_fetch_row( $handle );
		if (!$tmp) {
			print '<ul style="margin:0;">';
			$tmp = 1;
		}
		print "<li> <a href=\"mailto:$email\">$handle</a>\n";
	}
	if ($tmp) print '</ul>';
	else print "<p>The $team team doesn't have a leader.</p>";
	?>
		</td>
	</tr>
	</table>
	</td></tr></table>

	<?php
	$admin = mysql_query( "select admin from users where uid=$uid" );
	list( $admin ) = mysql_fetch_row( $admin );
	if ( $leader || $admin ) { ?>
	<br>
	<table border=0 cellpadding=1 cellspacing=0 width=175 bgcolor="black"><tr><td>
	<table border=0 cellpadding=3 cellspacing=0 width="100%" bgcolor="white">
	<tr>
		<?php if ( $leader ) { ?>
		<td><p>You're a leader of the <?=$team;?> team! Click <a href="teamedit.php?gid=<?=$team_num;?>">here</a> to edit the team info.</p></td>
		<?php } else { ?>
		<td><p>You're an admin! Click <a href="teamedit.php?gid=<?=$team_num;?>">here</a> to edit the <?=$team;?> team info.</p></td>
		<?php } ?>
	</tr>
	</table>
	</td></tr></table>
	<?php } ?>
</div>

<p style="font-size:medium;font-weight:bold;">The <?=$team;?> Team</p>
<p><b>Summary</b></p>
<p style="margin:0 5px 10px 10px;"><?=$summary;?></p>
<p><b>Status</b></p>
<p style="margin:0 5px 10px 10px;"><?=$status;?></p>

<p><b>Team Members</b></p>
<ul>
<?php
	$result = mysql_query( "select username,team,title,email,realname,location from users where team like '%$team_num%'" );
	while ( $dude = mysql_fetch_array($result) ) {
		$dude['team'] = explode( ',', $dude['team'] );
		$tmp = 0;
		while ($each = each($dude['team']) ) {
			if ($each['value'] == $team_num) { $tmp=1; break; }
		}
		if (!$tmp) continue;
?>
		<li> <a href="mailto:<?=$dude['email'];?>"><?=$dude['realname'];?></a> (aka <?=$dude['username'];?>) - <?=$dude['title'];?><?php if ($dude['location']) print ' from '.$dude['location']; ?>
<?php
	}
?>
</ul>
</p>

<?php main_footer(); ?>

