<?php
	include "functions.php";

	if ( !$uid && $action == 'login' ) {
		$result = mysql_query( "select * from users where username='$username'" );
		list( $uid, $dbusername, $dbpassword ) = mysql_fetch_row( $result );
		if ( $password == $dbpassword ) {
			// login successful
			session_register( 'uid' );
			session_register( 'dbusername' );
			session_register( 'dbpassword' );
		} else {
			unset( $uid );
		}
	} elseif ( $action == 'logout' && $uid ) {
		session_unregister( 'uid' );
		session_unregister( 'dbusername' );
		session_unregister( 'dbpassword' );
		unset( $uid, $dbusername, $dbpassword );
	} elseif ( $action == 'grab_todo' && $uid ) {
		$public = mysql_query( "select owner,public from todos where tid=$tid" );
		list( $todo_uid, $todo_public ) = mysql_fetch_row( $public );
		if ( $public == 0 ) {
			print '<p style="color:red;">That todo, if it even exists, isn\'t public.</p>';
		} else {
			if ( $uid == $todo_uid ) {
				// it's already theirs! let's just make it private
				$result = mysql_query( "update todos set public=0 where tid=$tid" );
			} else {
				// it's someone elses, let's move it over and make it private
				$result = mysql_query( "update todos set public=0 where tid=$tid" );
				$result = mysql_query( "update todos set owner=$uid where tid=$tid" );
			}
		}
	}

	#if ( !isset($show_privates) ) $show_privates = 1;    // default
	if ( !isset($list) )          $list = 'by_priority';
	if ( isset($ch_show_privates) ) {
		$show_privates = $ch_show_privates;
		session_register( 'show_privates' );
	}
	if ( isset($ch_list) ) {
		$list = $ch_list;
		session_register( 'list' );
	}

	main_header( 'Home' );

	if ( $action == 'login' && !$uid ) {
		// they tried to log in, but the uid wasn't
		// stashed into the session, so it was unsuccessful.
		print '<p style="color:red;">Alas, your login attempt was unsuccessful.</p>';
	}

	// show/hide privates
	if ( $show_privates == 1 ) {
		$query_where = '';
		$disptxt = " <a href=\"index.php?ch_show_privates=0\">(private todos shown; click to hide)</a>";
	} else {
		$query_where = ' and public!=0';
		$disptxt = " <a href=\"index.php?ch_show_privates=1\">(private todos hidden; click to show)</a>";
	}

	// ooh, now real content...
	if ( $list == 'by_priority' ) {
		print "<p style=\"font-size:medium;font-weight:bold;\">Sorted by priority/date$disptxt</p>";
		$result = mysql_query( "select * from todos where priority!=0$query_where order by priority desc,date desc" );
		while ( $todo = mysql_fetch_array($result) ) {
			print_todo( $todo['title'], $todo['tid'], $todo['owner'], $todo['date'], $todo['public'], $todo['priority'], $todo['longdesc'], $todo['team'], $todo['branch'] );
		}
	} elseif ( $list == 'by_date' ) {
		print "<p style=\"font-size:medium;font-weight:bold;\">Sorted by date$disptxt</p>";
		$result = mysql_query( "select * from todos where priority!=0$query_where order by date desc,priority desc" );
		while ( $todo = mysql_fetch_array($result) ) {
			print_todo( $todo['title'], $todo['tid'], $todo['owner'], $todo['date'], $todo['public'], $todo['priority'], $todo['longdesc'], $todo['team'], $todo['branch'] );
		}
	} elseif ( $list == 'by_developer' && !$uid ) {
		print "<p style=\"font-size:medium;font-weight:bold;\">Sorted by developer/priority/date$disptxt</p>";
		$result = mysql_query( "select * from todos where priority!=0$query_where order by owner,priority desc,date desc" );
		while ( $todo = mysql_fetch_array($result) ) {
			print_todo( $todo['title'], $todo['tid'], $todo['owner'], $todo['date'], $todo['public'], $todo['priority'], $todo['longdesc'], $todo['team'], $todo['branch'] );
		}
	} elseif ( $list == 'by_developer' && $uid ) {
		print "<p style=\"font-size:medium;font-weight:bold;\">Sorted by developer/priority/date$disptxt</p>";
		$result = mysql_query( "select * from todos where priority!=0 and owner=$uid$query_where order by priority desc,date desc" );
		while ( $todo = mysql_fetch_array($result) ) {
			print_todo( $todo['title'], $todo['tid'], $todo['owner'], $todo['date'], $todo['public'], $todo['priority'], $todo['longdesc'], $todo['team'], $todo['branch'] );
		}
		$result = mysql_query( "select * from todos where owner!=$uid and priority!=0$query_where order by owner,priority desc,date desc" );
		while ( $todo = mysql_fetch_array($result) ) {
			print_todo( $todo['title'], $todo['tid'], $todo['owner'], $todo['date'], $todo['public'], $todo['priority'], $todo['longdesc'], $todo['team'], $todo['branch'] );
		}
	}
	main_footer();
?>
