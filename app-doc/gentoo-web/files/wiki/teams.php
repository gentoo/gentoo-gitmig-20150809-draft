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

	$result = mysql_query( "select summary,status,leader from teams where gid=$team_num" );
	list( $summary, $status, $leader ) = mysql_fetch_array( $result );

	// are we a leader?
	$leaders = explode( ',', $leader );
	$leader = 0;
	while ( $each = each($leaders) ) {
		if ( $each['value'] == $uid ) {
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
		$handle = mysql_query( 'select username from users where uid='.$each['value'] );
		list( $handle ) = mysql_fetch_row( $handle );
		if (!$tmp) {
			print '<ul style="margin:0;">';
			$tmp = 1;
		}
		print "<li> $handle\n";
	}
	if ($tmp) print '</ul>';
	else print "<p>Team $team is unleaded!</p>";
	?>
		</td>
	</tr>
	</table>
	</td></tr></table>

	<?php if ( $leader ) { ?>
	<br>
	<table border=0 cellpadding=1 cellspacing=0 width=175 bgcolor="black"><tr><td>
	<table border=0 cellpadding=3 cellspacing=0 width="100%" bgcolor="white">
	<tr>
		<td><p>You are a leader of <?=$team;?>! Click <a href="teamedit.php?gid=<?=$team_num;?>">here</a> to edit the team info.</p></td>
	</tr>
	</table>
	</td></tr></table>
	<?php } ?>
</div>

<p style="font-size:medium;font-weight:bold;">Team <?=$team;?></p>
<p><b>Summary</b></p>
<p style="margin:0 5px 10px 10px;"><?=$summary;?></p>
<p><b>Status</b></p>
<p style="margin:0 5px 10px 10px;"><?=$status;?></p>

<p><b>Team Members</b></p>
<ul>
<?php
	$result = mysql_query( "select username,title,email,realname,location from users where team like '%$team_num%'" );
	while ( $dude = mysql_fetch_array($result) ) {
?>
	<li> <a href="mailto:<?=$dude['email'];?>"><?=$dude['realname'];?></a> (aka <?=$dude['username'];?>) - <?=$dude['title'];?> from <?=$dude['location'];?>
<?php
	}
?>
</ul>
</p>

<?php main_footer(); ?>

