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
		if ( $leader ) $leader = '1'; else $leader = '0';

		if ( $xuid == 'new' ) {
			// new user
			print '<p style="color:red;">You omitted vital information.</p>';
			mysql_query( "insert into users set username='$username',password='$pass1',admin=$admin,title='$title',email='$email',realname='$realname',team=$team" );
			
			if ( $leader ) mysql_query( "update teams set leader=$uid where gid=$team" );

			print '<p style="color:red;">User added to database.</p>';
		} else {
			// change existing
			$query = "update users set username='$username'";
			if ( $pass1 ) $query .= ",password='$pass1'";
			$query .= ",admin=$admin,title='$title',email='$email',realname='$realname',team='$team' where uid=$xuid";
			mysql_query( $query );

			if ( $leader ) mysql_query( "update teams set leader=$xuid where gid=$team" );

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

		// are we leader?
		$result = mysql_query( 'select leader from teams where gid='.$dude['team'] );
		list( $leader ) = mysql_fetch_row( $result );
		if ( $leader == $xuid ) $leader=1; else $leader=0;
	}
	?>
	<form action="useredit.php" method="post">
	<table border=0 cellpadding=2 cellspacing=0>
	<tr>
		<td align="right"><b>Real Name:</b></td>
		<td><input type="text" name="realname" maxlength=200 value="<?=$dude['realname'];?>"></td>
	</tr>
	<tr>
		<td align="right"><b>Username:</b></td>
		<td><input type="text" name="username" maxlength=10 value="<?=$dude['username'];?>"></td>
	</tr>
	<tr>
		<td align="right"><b>/<br>Password:<br>\</b></td>
		<td><input type="password" name="pass1" maxlength=10><br><input type="password" name="pass2" maxlength=10></td>
		<td><p>Type in a password twice to change</p></td>
	</tr>
	<tr>
		<td align="right"><b>Title:</b></td>
		<td><input type="text" name="title" maxlength=100 value="<?=$dude['title'];?>"></td>
	</tr>
	<tr>
		<td align="right"><b>Email:</b></td>
		<td><input type="input" name="email" value="<?=$dude['email'];?>"></td>
	</tr>
	<tr>
		<td align="right"><b>Team:</b></td>
		<td><select name="team"><?php
			$team = team_num_name( $dude['team'] );
			if ( $team == 'None' ) {
				print '<option>None</option><option>System</option><option>Desktop</option><option>Server</option><option>Tools</option><option>Infrastructure</option>';
			} elseif ( $team == 'System' ) {
				print '<option>System</option><option>None</option><option>Desktop</option><option>Server</option><option>Tools</option><option>Infrastructure</option>';
			} elseif ( $team == 'Desktop' ) {
				print '<option>Desktop</option><option>None</option><option>System</option><option>Server</option><option>Tools</option><option>Infrastructure</option>';
			} elseif ( $team == 'Server' ) {
				print '<option>Server</option><option>None</option><option>Desktop</option><option>System</option><option>Tools</option><option>Infrastructure</option>';
			} elseif ( $team == 'Tools' ) {
				print '<option>Tools</option><option>None</option><option>Desktop</option><option>Server</option><option>System</option><option>Infrastructure</option>';
			} elseif ( $team == 'Infrastructure' ) {
				print '<option>Infrastructure</option><option>None</option><option>Desktop</option><option>Server</option><option>Tools</option><option>System</option>';
			}
		?></select></td>
	</tr>
	<tr>
		<td align="right"><b>Team Leader:</b></td>
		<td><input type="checkbox" name="leader"<?php if ( $leader ) print ' checked'; ?>></td>
	</tr>
	<tr>
		<td align="right"><b>Admin:</b></td>
		<td><input type="checkbox" name="admin"<?php if ( $dude['admin'] ) print ' checked'; ?>></td>
	</tr>
	</table>
	<input type="hidden" name="submitted" value="1">
	<input type="hidden" name="xuid" value="<?=$xuid;?>">
	<p><input type="submit" value="Submit"></p>
	</form>
	<?php
}

main_footer();
?>
