<?php
include "functions.php";
main_header( 'Edit User Listing' );

// are we an admin?
$query = mysql_query( "select admin from users where uid=$uid" );
list( $priv ) = mysql_fetch_row( $query );

if ( !$priv ) {
	print '<p style="color:red;">You don\'t appear to be an admin.</p>';
	main_footer();
	exit;
}

if ( $submitted ) {
	if ( $pass1 != $pass2 ) {
		print '<p style="color:red;">Your password fields did not match.</p>';
	} else {
		// stuff that needs to be done for both
		$team = team_name_num( $team );
		if ( $admin ) $admin = '1'; else $admin = '0';
		reset( $teams );
		while ( $cur = each($teams) ) { // construct special teams value
			if ( $$cur['value'] == 'r' || $$cur['value'] == 'l' ) $tms[] = $cur['key'];
			if ( $$cur['value'] == 'l' ) $leads[] = $cur['key'];
		}
		if ( $tms ) {
			$team = implode( ',', $tms );
		} else {
			$team = '';
		}


		// grant leaderships
		if ( $leads ) {
			while ( $cur = each($leads) ) {
				if (!$cur['value']) break;
				$leaders = mysql_query( 'select leader from teams where gid='.$cur['value'] );
				list( $leaders ) = mysql_fetch_row( $leaders );
				$leaders = explode( ',', $leaders );
				$tmp = 0;

				// make sure they're not already a leader; skip this group if so.
				unset( $newlead );
				reset( $leaders );
				while ( $each = each($leaders) ) {
					if ( $each['value'] == $xuid ) {
						// whoops! this guy's already a lead of the group
						$tmp = 1;
						break;
					}
					if ( $each['value'] != '0' ) $newlead[] = $each['value'];
				}
				if ($tmp) continue; // next group

				// add 'em
				if ( sizeof($newlead) == 0 ) {
					$newlead = $xuid;
				} else {
					$newlead[] = $xuid;
					$newlead = implode( ',', $newlead );
				}
				mysql_query( "update teams set leader='$newlead' where gid=".$cur['value'] );
			}
		}

		// revoke leaderships
		$oldleads = explode( ',', $oldleads );
		if ($leads) reset( $leads );
		reset( $oldleads );
		while ( $ol = each($oldleads) ) {
			if (!$ol['value']) break;
			$tmp = 1;
			if ( $leads ) {
				reset( $leads );
				while ( $g = each($leads) ) {
					if ( $g['value'] == $ol['value'] ) { $tmp = 0; break; }
				}
			}
			if ( $tmp ) {
				// kill 'em. :(
				$leaders = mysql_query( 'select leader from teams where gid='.$ol['value'] );
				list( $leaders ) = mysql_fetch_row( $leaders );
				$leaders = explode( ',', $leaders );
				unset( $newl );
				reset( $leaders );
				while ( $each = each($leaders) ) {
					// we're removing the user. if we hit the xuid, skip 'em,
					// otherwise, pile 'em onto the new array
					if ( $each['value'] == $xuid ) continue;
					$newl[] = $each['value'];
				}

				if ( sizeof($newl) == 0 ) {
					$newl = '';
				} else {
					$newl = implode( ',', $newl ); // compile the new var
				}
				mysql_query( "update teams set leader='$newl' where gid=".$ol['value'] );
			}
		}

		// whew - now changing simple user info seems like a breeze :)
		if ( $xuid == 'new' ) {
			// new user
			mysql_query( "insert into users set username='$username',password='$pass1',admin=$admin,title='$title',email='$email',realname='$realname',location='$location',team='$team'" );
			$xuid = mysql_insert_id();
			print '<p style="color:red;">User added to database.</p>';
		} else {
			// change existing
			$query = "update users set username='$username'";
			if ( $pass1 ) $query .= ",password='$pass1'";
			$query .= ",admin=$admin,title='$title',email='$email',realname='$realname',location='$location',team='$team' where uid=$xuid";
			mysql_query( $query );

			print '<p style="color:red;">User information updated.</p>';
		}
	}
}

if ( !$xuid ) {
	?>

	<p style="font-size:medium;font-weight:bold;">User Listing</p>

	<ul>
		<li> <a href="useredit.php?xuid=new">Create new user</a>
	<?php

	$result = mysql_query( "select uid,username from users order by username" );

	while ( list($xuid,$dude) = mysql_fetch_row($result) ) {
		?>
		<li> <a href="useredit.php?xuid=<?=$xuid;?>"><?=$dude;?></a>
		<?php
	}
	?>
	</ul>
	<?php
} else {
	if ( $xuid != 'new' ) {
		// otherwise, we'll just keep all values empty
		$dude = mysql_query( "select * from users where uid=$xuid" );
		$dude = mysql_fetch_array( $dude );

		$xteams = explode( ",", $dude['team'] );
	}
	?>
	<form action="useredit.php" method="post">
	<table border=0 cellpadding=2 cellspacing=0>
	<tr>
		<td align="right"><b>uid:</b></td>
		<td><?=$dude['uid'];?></td>
	</tr>
	<tr>
		<td align="right"><b>Real Name:</b></td>
		<td><input type="text" name="realname" maxlength=200 value="<?=$dude['realname'];?>"></td>
	</tr>
	<tr>
		<td align="right"><b>Username:</b></td>
		<td><input type="text" name="username" maxlength=10 value="<?=$dude['username'];?>"></td>
	</tr>
	<tr>
		<td align="right"><b>Password:</b><br>(Type in a<br>password twice<br>to change.)</td>
		<td><input type="password" name="pass1" maxlength=10><br><input type="password" name="pass2" maxlength=10></td>
	</tr>
	<tr>
		<td align="right"><b>Title:</b></td>
		<td><input type="text" name="title" maxlength=100 value="<?=$dude['title'];?>"></td>
	</tr>
	<tr>
		<td align="right"><b>Email:</b></td>
		<td><input type="input" name="email" value="<?=$dude['email'];?>" maxlength=200></td>
	</tr>
	<tr>
		<td align="right"><b>Location:</b></td>
		<td><input type="input" name="location" value="<?=$dude['location'];?>" maxlength=200></td>
	</tr>
	<tr>
		<td align="right"><b>Admin:</b></td>
		<td><input type="checkbox" name="admin"<?php if ( $dude['admin'] ) print ' checked'; ?>></td>
	</tr>
	<tr>
		<td align="right" valign="top"><b>Team Memberships:</b></td>
		<td>
		<table border=0 cellpadding=1 cellspacing=0 bgcolor="black"><tr><td>
		<table width=300 border=0 cellpadding=5 cellspacing=0 bgcolor="#bdbacc">
		<tr>
			<td>&nbsp;</td>
			<td align="center"><b>Unaffiliated</b></td>
			<td align="center"><b>Regular</b></td>
			<td align="center"><b>Leader</b></td>
		</tr>
		<?php
		// get team info
		reset( $teams );
		while ( $each = each($teams) ) {
			if ( $each['key'] == 0 || $each['key'] == 1 ) continue; // skip 'none' and 'all'
			$tm = 'u'; // set the default
			if ( $xuid != 'new' ) {
				// are they a simple member? ...
				reset( $xteams );
				while ( $cur = each($xteams) ) {
					if ( $cur['value'] == $each['key'] ) $tm = 'r';
				}
				// are they the team LEADER?!?! :)
				$ldr = mysql_query( 'select leader,gid from teams where gid='.$each['key'] );
				list( $ldr, $thegid ) = mysql_fetch_row( $ldr );
				$ldr = explode( ',', $ldr );
				reset( $ldr );
				while ( $pair = each($ldr) ) {
					if ( $pair['value'] == $xuid ) {
						$tm = 'l';
						$oldlead[] = $thegid;
						break;
					}
				}
			}
			?>
		<tr>
			<td><b><?=$each['value'];?></b></td>
			<td align="center"><input type="radio" name="<?=$each['value'];?>" value="u"<?php if ($tm=='u') print ' checked'; ?>></td>
			<td align="center"><input type="radio" name="<?=$each['value'];?>" value="r"<?php if ($tm=='r') print ' checked'; ?>></td>
			<td align="center"><input type="radio" name="<?=$each['value'];?>" value="l"<?php if ($tm=='l') print ' checked'; ?>></td>
		</tr>
			<?php
		}
		?>
		</table>
		</td></tr></table>
		</td>
	</tr>
	<tr>
		<input type="hidden" name="submitted" value="1">
		<input type="hidden" name="oldleads" value="<?php if ($oldlead) print implode( ',', $oldlead );?>">
		<input type="hidden" name="xuid" value="<?=$xuid;?>">
		<td align="center" colspan=2><input type="submit" value="Submit"></td>
	<tr>
	</table>
	</form>
	<?php
}

main_footer();
?>
