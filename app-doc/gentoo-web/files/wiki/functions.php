<?php
	session_start();
	mysql_connect( 'localhost', '##USER##', '##PASS##' );
	mysql_select_db( '##DB##' );

	// tags to allow for output
	$allow_tags = "<a>,<br>,<b>,<u>";

	// make sure our uid, which dictates whether they're logged in or not, is all straight
	if ( !isset($uid) ) {
		$uid = 0;
		session_register( 'uid' );
	} else {
		$uid = auth( $dbusername, $dbpassword );
	}
?>

<?php function main_header ( $title = 'Unknown' ) {
global $uid, $dbusername; ?>
<!DOCTYPE HTML PUBLIC "http://www.w3.org/TR/REC-html40/loose.dtd" "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>Gentoo Linux Dev-Wiki - <?=$title;?></title>
<style type="text/css">
<!--
	a:link		{font-weight: bold; font-size: xx-small; color: blue; }
	a:visited	{font-weight: bold; font-size: xx-small; color: blue; }
	a:hover		{font-weight: bold; font-size: xx-small; color: red; }
	a:active	{font-weight: bold; font-size: xx-small; color: red; }

	body		{background-color: #dddaec; color: black; font-size: x-small;
			font-family: Verdana, Helvetica, Sans-serif; margin:0;
			padding:0; font-size: xx-small; }

	p		{font-size: xx-small; }
	td		{font-size: xx-small; }
-->
</style>
</head>
<body topmargin=0 leftmargin=0 bgcolor="#dddaec">

<table width="100%" height=96 border=0 cellpadding=0 cellspacing=0>
<tr>
	<td align="left"><img src="images/title.gif" width=292 height=96 alt="gentoo linux dev-wiki"></td>
	<td align="right" background="images/titlebg.gif" width="100%" valign="top">&nbsp;<?php
		if ( $uid ) { print "<p style=\"margin:0;padding:0 5px 0 0;color:#e0e0e0;\">Logged in as $dbusername.</p>\n<a href=\"index.php?action=logout\"><img src=\"images/logout.gif\" border=0></a>"; }
	?></p></td>
</tr>
</table>

<table width="95%" border=0 cellpadding=10 cellspacing=0 align="center">
<tr>
	<td bgcolor="#dddaec" valign="top">
<?php } # main header ?>

<?php function main_footer () {
global $uid, $dbusername, $show_privates, $list; ?>
	</td>
	<td width="175" valign="top">

<?php if ( !$uid ) { ?>

		<table width="100%" border=0 cellpadding=1 cellspacing=0 bgcolor="black"><tr><td>
		<table width="100%" border=0 cellpadding=3 cellspacing=0>
		<tr>
			<td bgcolor="#7bc1f7"><b>Login</b></td>
		</tr>
		<tr>
			<td bgcolor="white">
			<form method="post" action="index.php?action=login">
			<table width="100%" border=0 cellpadding=2 cellspacing=0>
			<tr>
			       	<td><p>Username:</p></td>
			        <td><input type="text" name="username" size=10></td>
			</tr>
			<tr>
				<td><p>Password:</p></td>
			        <td><input type="password" name="password" size=10></td>
			</tr>
			<tr>
			        <td align="center" colspan=2><input type="submit" value="login"></td>
			</tr>
			</table>
			</form>
			</td>
		</tr>
		</table>
		</td></tr></table>

		<img src="images/spacer.gif" height=10 alt="">
<?php } ?>

		<table width="100%" border=0 cellpadding=1 cellspacing=0 bgcolor="black"><tr><td>
		<table width="100%" border=0 cellpadding=3 cellspacing=0>
		<tr>
			<td bgcolor="#7bc1f7"><b>Gentoo Linux Dev-Wiki</b></td>
		</tr>
		<tr>
			<td bgcolor="white">
			<ul>
				<li><a href="index.php?list=by_priority">List by priority</a>
				<li><a href="index.php?list=by_date">List by date</a>
				<li><a href="index.php?list=by_developer">List by developer</a>
				<li><a href="completed.php">List completed</a>
			</ul>
				<?php if ( $uid ) { ?>
			<ul>
					<li><a href="single.php?action=new_todo">Create a new todo</a>
					<li><a href="profileedit.php">Edit user profile</a>
					<?php
					// are we a team leader?
					$query = mysql_query( "select leader,gid from teams" );
					while ( $row = mysql_fetch_array($query) ) {
						if ( $row['leader'] == $uid ) {
							$leaderof = team_num_name( $row['gid'] );
							break;
						}
					}
					// are we an admin?
					$query = mysql_query( "select admin from users where uid=$uid" );
					list( $admin ) = mysql_fetch_row( $query );

					if ( $leaderof ) { ?>
						<li><a href="teamedit.php">Edit team <?=$leaderof;?></a>
					<?php }
					if ( $admin ) { ?>
						<li><a href="useredit.php">Edit Users</a>
					<?php } ?>
			</ul>
				<? } ?>

			<p style="font-size:x-small;font-weight:bold;">Teams</p>
			<ul>
				<li><a href="teams.php?team=system">System</a>
				<li><a href="teams.php?team=desktop">Desktop</a>
				<li><a href="teams.php?team=server">Server</a>
				<li><a href="teams.php?team=tools">Tools</a>
				<li><a href="teams.php?team=infrastructure">Infrastructure</a>
			</ul>


			<p style="font-size:x-small;font-weight:bold;">Developers</p>
			<ul>
<?php
			$result = mysql_query( "select uid,username from users order by username" );
			while ( $dev = mysql_fetch_row( $result ) ) {
				print "\t\t\t<li><a href=\"devtodo.php?devid=$dev[0]\">$dev[1]</a>\n";
			}
?>
			</ul>

			<p style="font-size:x-small;font-weight:bold;">Go</p>
			<ul>
				<li><a href="http://www.gentoo.org">Gentoo Linux</a>
			</ul>
			</td>
		</tr>
		</table>
		</td></tr></table>
	</td>
</tr>
</table>

<table width="100%" border=0 cellpadding=3 cellspacing=0><tr><td bgcolor="#7a5ada">
	<p style="margin:0;padding:0;color:#e0e0e0;font-weight:bold;text-align:right;">Copyright 2001 Gentoo Technologies, Inc. / coding by <a href="http://www.threadbox.net">Thread</a></p>
</td></tr></table>

</body>
</html>
<?php } #main_footer ?>

<?php function print_todo( $title, $tid, $owner, $date, $public, $priority, $longdesc, $team, $branch ) {
	// all args should be passed hot off the database
	global $list, $uid, $allow_tags;

	// strop unacceptable tags
	$title = strip_tags( $title, $allow_tags );
	$longdesc = strip_tags( $longdesc, $allow_tags );

	$date = date( "j M Y", $date );

	$developer = mysql_query( "select username from users where uid=$owner" );
	list( $developer ) = mysql_fetch_row( $developer );

	if ( $public == 1 )
		$pubwords = "public task";
	else
		$pubwords = "private task";

	if ( $public == 0 ) {
		$tabcolor = '#c0c0c0';
	} elseif ( $priority == 0 ) {
		$priority = 'completed';
		$tabcolor = 'white';
	} elseif ( $priority == 1 ) {
		$priority = 'low';
		$tabcolor = '#7bf77b';
	} elseif ( $priority == 2 ) {
		$priority = 'medium';
		$tabcolor = '#f7ef7b';
	} elseif ( $priority == 3 ) {
		$priority = 'hi';
		$tabcolor = '#fa9779';
	}

	$followups = mysql_query( "select fid from followups where tid=$tid" );
	$followups = mysql_num_rows( $followups );
	if ( $followups == 1 )
		$word = 'follow-up';
	else
		$word = 'follow-ups';
	$followups = "$followups $word";

	$team = team_num_name( $team );
	$branch = '';
	if ( $team != 'Infrastructure' ) {
		$branch = '-'.branch_num_name( $branch );
	}
		
	?>
	<table width="100%" border=0 cellpadding=1 cellspacing=0 bgcolor="black"><tr><td>
	<table width="100%" border=0 cellpadding=3 cellspacing=0>
	<tr>
		<td bgcolor="<?=$tabcolor;?>" align="left"><b><?=$title;?></b></td>
		<td bgcolor="<?=$tabcolor;?>" align="right"><b><?=$pubwords;?></b> / <?=$date;?></td>
	</tr>
	<tr>
		<td bgcolor="white" colspan=2>
			<p style="padding:0;margin:0;"><?=$longdesc;?></p>
			<p align="right" style="padding:5px 0 0 0;margin:0;"><?php if ($uid && $public == 1) { print "<a href=\"index.php?action=grab_todo&tid=$tid\">I'll do it</a> | "; } ?><a href="single.php?tid=<?=$tid;?>">details</a> (<?=$followups;?>)<br><?php if ( $public ) print 'Posted'; else print 'Owned'; ?> by <a href="devtodo.php?devid=<?=$owner;?>"><b><?=$developer;?></b></a> on <?=$team;?><?=$branch;?></p>
		</td>
	</tr>
	</table>
	</td></tr></table>

	<img src="images/spacer.gif" height=7 alt="">
	<?php
} ?>

<?php function auth ( $user, $pass ) {
	// takes a username and a password and returns the uid if it's valid. 0 if it's not.
	$result = mysql_query( "select uid from users where username='$user' and password='$pass'" );
	if ( mysql_num_rows($result) ) {
		list($uid) = mysql_fetch_row($result);
		return $uid;
	} else {
		return 0;
	}
} ?>

<?php function team_num_name ( $num ) {
	if     ( $num == 0 ) $team = 'None';
	elseif ( $num == 1 ) $team = 'All';
	elseif ( $num == 2 ) $team = 'System';
	elseif ( $num == 3 ) $team = 'Desktop';
	elseif ( $num == 4 ) $team = 'Server';
	elseif ( $num == 5 ) $team = 'Tools';
	elseif ( $num == 6 ) $team = 'Infrastructure';
	return $team;
} ?>

<?php function team_name_num ( $name ) {
	if     ( $name == 'None' )           $num = 0;
	elseif ( $name == 'All' )            $num = 1;
	elseif ( $name == 'System' )         $num = 2;
	elseif ( $name == 'Desktop' )        $num = 3;
	elseif ( $name == 'Server' )         $num = 4;
	elseif ( $name == 'Tools' )          $num = 5;
	elseif ( $name == 'Infrastructure' ) $num = 6;
	return $num;
} ?>

<?php function branch_num_name ( $num ) {
	if     ( $num == 0 ) $branch = 'none';
	elseif ( $num == 1 ) $branch = 'all';
	elseif ( $num == 2 ) $branch = 'stable';
	elseif ( $num == 3 ) $branch = 'unstable';
	return $branch;
} ?>
