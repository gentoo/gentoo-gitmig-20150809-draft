<?php
	include "functions.php";
	main_header( 'Edit todo' );

	if ( !$uid ) {
		print '<p style="color:red;">You\'re not logged in!</p>';
	}

	if ( $action == 'post_followup' && $uid && $followup ) {
		// if they just hit refresh after posting, the post will be resubmitted.
		// now, i'm going to make sure the same followup doesn't get posted twice.
		$already = mysql_query( "select fid from followups where followup='$followup' and tid='$tid'" );
		list( $already ) = mysql_fetch_array( $already );
		if ( !$already ) {
			// okay, it's not in there. let's submit.
			$result = mysql_query ( "insert into followups set tid=$tid,uid=$uid,date=".time().",followup='$followup'" );
		}
	}

	if ( !$committed && $action != 'new_todo' ) {
		$todo = mysql_query( "select * from todos where tid=$tid" );
		$todo = mysql_fetch_array( $todo );
	}
	if ( $committed || $action == 'new_todo' ) {
		// they're logged in and want to create a new todo. We want to
		// skip over the rest of these checks.
	} elseif ( !$todo['tid'] ) {
		// tid wasn't in the database
		print '<p style="color:red;">Something bad happened: The specified todo doesn\'t seem to be available. Hopefully, you know what\'s going on.</p>';
		main_footer();
		exit;
	} elseif ( $todo['owner'] != $uid ) {
		// this todo doesn't belong to the guy who's logged in
		print '<p style="color:red;">Sorry, but it appears as though the todo you\'re attempting to edit does not belong to you.</p>';
		main_footer();
		exit;
	}
	if ( $committed ) {
		// okay, they just submitted an update. Let's validate and commit it.
		if ( !$title || !$longdesc ) {
			print '<p style="color:red;">You left out vital info. (title and/or todo description.) Please back up and try again.</p>';
		} else {
			if ( $priority == "low" ) $priority = 1;
			elseif ( $priority == "med" ) $priority = 2;
			elseif ( $priority == "hi" ) $priority = 3;
			else $priority = 0;
			
			if ( $sharing == 'public' ) $sharing = 1;
			else $sharing = 0;

			if ( $action == 'new_todo' ) {
				$already = mysql_query( "select tid from todos where longdesc='$longdesc' and title='$title'" );
				list( $already ) = mysql_fetch_array( $already );
				if ( !$already ) {
					$query = "insert into todos set owner=$uid,title='$title',public=$sharing,priority=$priority,date=".time().",longdesc='$longdesc'";
					if ( $priority == 0 ) $query .= ",datecompleted=".time();
					$result = mysql_query( $query );
					$tid = mysql_insert_id();
					print '<p style="color:red;">Todo added.</p>';
				}
			} else {
				$query = "update todos set title='$title',public=$sharing,priority=$priority,longdesc='$longdesc'";
				if ( $priority == 0 ) $query .= ",datecompleted=".time();
				$query .= " where tid=$tid";
				$result = mysql_query( $query );
				print '<p style="color:red;">Change(s) committed.</p>';
			}
			// now we'll do the query that we skipped at the beginning
			$todo = mysql_query( "select * from todos where tid=$tid" );
			$todo = mysql_fetch_array( $todo );
		}
	}
	if ( $todo['priority'] == 0 ) {
		$priority = 'complete';
	} elseif ( $todo['priority'] == 1 ) {
		$priority = 'low';
	} elseif ( $todo['priority'] == 2 ) {
		$priority = 'med';
	} elseif ( $todo['priority'] == 3 ) {
		$priority = 'hi';
	}

	if ( $todo['public'] == 1 ) {
		$public = 'public';
	} else {
		$public = 'private';
	}

	if ( $action == 'new_todo' ) {
		$priority = 'low';
		$public = 'private';
	}

?>
<p>&nbsp;</p>
<form method="post" action="editsingle.php?action=<?php if ( $action == 'new_todo' ) print 'new_todo'; else print 'update'; ?>">
<table width="90%" border=0 cellpadding=3 cellspacing=0 align="center" bgcolor="#46357c"><tr><td>
<table width="100%" border=0 cellpadding=3 cellspacing=0>
<tr>
	<td align="center" bgcolor="#46357c"><p style="padding:0;margin:0;color:white;font-weight:bold;"><input type="text" name="title" maxlength=100 size=50 value="<?=$todo['title'];?>"></p></td>
</tr>
<tr>
	<td bgcolor="#dddaec">
		<table width="100%" border=0 cellpadding=5 cellspacing=0>
		<tr>
			<td width="50%" valign="top">
			<p>
				<b>Developer:</b> <?=$dbusername;?><br>
				<?php if ( $action == 'new_todo' ) { ?>
					<b>Todo (will be) posted:</b> <?=date( "n/j/y", time() );?><br>
				<?php } else { ?>
					<b>Todo posted:</b> <?=date( "n/j/y", $todo['date'] );?><br>
				<?php } ?>
			</p>
			</td>
			<td>
			<p>
				<b>Priority:</b> <select name="priority"><?php
					if ( $priority == 'hi' ) {
						print '<option>hi</option><option>med</option><option>low</option><option>complete</option>';
					} elseif ( $priority == 'med' ) {
						print '<option>med</option><option>hi</option><option>low</option><option>complete</option>';
					} elseif ( $priority == 'complete' ) {
						print '<option>complete</option><option>low</option><option>med</option><option>hi</option>';
					} else {
						print '<option>low</option><option>med</option><option>hi</option><option>complete</option>';
					}
				?></select><br>
				<b>Sharing:</b> <select name="sharing"><?php
					if ( $public == 'public' ) {
						print '<option>public</option><option>private</option>';
					} else {
						print '<option>private</option><option>public</option>';
					}
				?></select>
			</p>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td bgcolor="white" align="center"><textarea name='longdesc' rows=7 cols=55><?=$todo['longdesc'];?></textarea><br>
	<input type="hidden" name="committed" value="1">
	<input type="hidden" name="tid" value="<?=$tid;?>">
	<input type="submit" value="Commit"></td>
</tr>
</table>
</td></tr></table>
</form>

<?php if ( $action != 'new_todo' ) { ?>
<div width=200 style="float:right;">
	<p>&nbsp;</p>
	<table width=200 border=0 cellpadding=3 cellspacing=0 bgcolor="#46357c"><tr><td>
	<table width="100%" border=0 cellpadding=5 cellspacing=0 bgcolor="white"><tr><td>
		<form method="post" action="editsingle.php?action=post_followup&tid=<?=$tid;?>">
		<p style="font-weight:bold;">Post a Followup!</p>
		<p>
			<textarea cols=20 rows=5 name="followup"></textarea><br>
			<input type="submit" value="Post">
		</p>
		</form>
	</td></tr></table>
	</td></tr></table>
</div>

<?php
	// okay, now we get to spit out all the followups.
	$result = mysql_query( 'select * from followups where tid='.$tid.' order by date desc' );
	while ( $fup = mysql_fetch_array( $result ) ) {
		$fuser = mysql_query( 'select username from users where uid='.$fup['uid'] );
		list( $fuser ) = mysql_fetch_row( $fuser );
?>
	<p style="margin:15px 5px 5px 5px;">Posted by <b><?=$fuser;?></b> on <b><?=date( "n/j/y", $fup['date'] );?></b></p>
	<p style="margin:0 5px 5px 15px"><?=$fup['followup'];?></p>

<?php
	}
}

main_footer(); ?>
