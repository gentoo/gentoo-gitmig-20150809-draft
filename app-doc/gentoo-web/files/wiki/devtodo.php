<?php
	include "functions.php";

	main_header( 'Todo by developer' );

	if ( !$devid ) $devid = $uid;
	$dude = mysql_query( "select * from users where uid=$devid" );
	$dude = mysql_fetch_array( $dude );
?>
<p style="font-size:medium;font-weight:bold;"><?=$dude['username'];?>'s Bio</p>
<table width="95%" border=0 cellpadding=5 cellspacing=0>
<tr>
	<td width=150 valign="top"><table border=0 cellpadding=1 cellspacing=0 bgcolor="black"><tr><td><img src="bios/<?php if (file_exists('bios/'.$dude['uid'].'.png')) print $dude['uid'].'.png'; else print '0.png'; ?>" width=150 height=150 alt="<?=$dude['username'];?>"></td></tr></table></td>

	<td valign="top">
	<table border=0 cellpadding=2 cellspacing=0>
	<tr>
		<td><b>Real Name:</b></td>
		<td><?=$dude['realname'];?></td>
	</tr>
	<tr>
		<td><b>Title:</b></td>
		<td><?=$dude['title'];?></td>
	</tr>
	<tr>
		<td><b>Location:</b></td>
		<td><?=$dude['location'];?></td>
	</tr>
	<tr>
		<td><b>Email:</b></td>
		<td><a href="mailto:<?=$dude['email'];?>"><?=$dude['email'];?></a></td>
	</tr>
	<tr>
		<td valign="top"><b>Teams:</b></td>
		<td>
		<table border=0 cellpadding=1 cellspacing=0 bgcolor="black"><tr><td>
		<table border=0 cellpadding=2 cellspacing=0 bgcolor="#bdbacc">
		<tr>
			<td>&nbsp;</td>
			<td align="center"><b>Regular&nbsp;&nbsp;</b></td>
			<td align="center"><b>Leader</b></td>
		</tr>
		<?php
		// get team info
		$xteams = $dude['team'];
		$xteams = explode( ',', $xteams );
		while ( $each = each($teams) ) {
			if ( $each['key'] == 0 || $each['key'] == 1 ) continue; // skip 'none' and 'all'
			$tm = 'u'; // set the default
			if ( $devid != 'new' ) {
				// are they a simple member? ...
				reset( $xteams );
				while ( $cur = each($xteams) ) {
					if ( $cur['value'] == $each['key'] ) { $tm = 'r'; break; }
				}
				// are they the team LEADER?!?! :)
				$ldr = mysql_query( 'select leader,gid from teams where gid='.$each['key'] );
				list( $ldr, $thegid ) = mysql_fetch_row( $ldr );
				$ldr = explode( ',', $ldr );
				reset( $ldr );
				while ( $pair = each($ldr) ) {
					if ( $pair['value'] == $devid ) {
						$tm = 'l';
						$oldlead[] = $thegid;
						break;
					}
				}
			}
			if ($tm!='u') {
			?>
		<tr>
			<td><b><?=$each['value'];?></b></td>
			<td align="center"><?php if ($tm=='r') print '<img src="images/dot.gif" width=10 height=10 alt="">'; else print '&nbsp;'; ?></td>
			<td align="center"><?php if ($tm=='l') print '<img src="images/dot.gif" width=10 height=10 alt="">'; else print '&nbsp;'; ?></td>
		</tr>
			<?php
			}
		}
		?>
		</table>
		</td></tr></table>
		</td>
	</tr>
	</table>
	</td>

</tr>
</table>

<p>&nbsp;</p>

<p style="font-size:medium;font-weight:bold;"><?=$dude['username'];?>'s uncompleted todos</p>
<table width="95%" border=0 cellpadding=2 cellspacing=2>
<?php if ( $uid == $devid ) { ?>
<tr>
	<td colspan=5 align="right">You're logged in. Clicking on a todo will take you to an edit page.<br>
	or... <a href="single.php?action=new_todo">Create a new todo</a>.</td>
</tr>
<?php } ?>
<tr>
	<td>&nbsp;</td>
	<td bgcolor="#dddaec"><b>Date</b></td>
	<td bgcolor="#dddaec"><b>Title</b></td>
	<td bgcolor="#dddaec"><b>Section</b></td>
	<td bgcolor="#dddaec"><b>Followups</b></td>
</tr>
<?php
		$result = mysql_query( "select * from todos where owner=$devid and priority!=0 and public=0 order by priority desc, date" );
		while ( $todo = mysql_fetch_array($result) ) {
			if ( $todo['priority'] == 1 ) {
				$priority = 'low';
			} elseif ( $todo['priority'] == 2 ) {
				$priority = 'med';
			} elseif ( $todo['priority'] == 3 ) {
				$priority = 'hi';
			}
			$fupcount = mysql_query( 'select fid from followups where tid='.$todo['tid'] );
			$fupcount = mysql_num_rows( $fupcount );

			$team = team_num_name( $todo['team'] );
			$branch = '';
			if ( $team != 'Infrastructure' ) {
				$branch = '/'.branch_num_name( $todo['branch'] );
			}
?>
<tr>
	<td><img src="images/<?=$priority;?>.gif" alt="<?=$priority;?>"></td>
	<td><?=date( "n/j/y", $todo['date'] );?></td>
	<td><a href="single.php?tid=<?=$todo['tid'];?>"><?=$todo['title'];?></a></td>
	<td><?=$team.$branch;?></td>
	<td><?=$fupcount;?></td>
</tr>
<?php 
		}
?>
</table>

<p>&nbsp;</p>

<p style="font-size:medium;font-weight:bold;"><?=$dude['username'];?>'s completed todos</p>
<table width="95%" border=0 cellpadding=2 cellspacing=2>
<tr>
	<td bgcolor="#dddaec"><b>Title</b></td>
	<td bgcolor="#dddaec"><b>Section</b></td>
	<td bgcolor="#dddaec"><b>Followups</b></td>
	<td bgcolor="#dddaec"><b>Existed</b></td>
</tr>
<?php
		$result = mysql_query( "select * from todos where owner=$devid and priority=0 order by datecompleted" );
		while ( $todo = mysql_fetch_array($result) ) {

			$fupcount = mysql_query( 'select fid from followups where tid='.$todo['tid'] );
			$fupcount = mysql_num_rows( $fupcount );

			$team = team_num_name( $todo['team'] );
			$branch = '';
			if ( $team != 'Infrastructure' ) {
				$branch = '/'.branch_num_name( $todo['branch'] );
			}
?>
<tr>
	<td><a href="single.php?tid=<?=$todo['tid'];?>"><?=$todo['title'];?></a></td>
	<td><?=$team.$branch;?></td>
	<td><?=$fupcount;?></td>
	<td><?=date( "n/j/y", $todo['date'] );?>-<?=date( "n/j/y", $todo['datecompleted'] );?></td>
</tr>
<?php 
		}
?>
</table>

<?php main_footer(); ?>
