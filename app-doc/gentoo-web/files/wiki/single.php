<?php
	include "functions.php";
	main_header( 'Todo' );

	if ( $committed && $uid ) {
		// okay, they just submitted an update. Let's validate and commit it.
		if ( !$title || !$longdesc ) {
			print '<p style="color:red;">You left out vital info. (title and/or todo description.) Please back up and try again.</p>';
		} else {
			if     ( $priority == "low" ) $priority = 1;
			elseif ( $priority == "med" ) $priority = 2;
			elseif ( $priority == "hi" )  $priority = 3;
			else                          $priority = 0;

			$branch = branch_name_num( $branch );

			$team = team_name_num( $team );
			
			if   ( $sharing == 'public' ) $sharing = 1;
			else                          $sharing = 0;

			if ( $action == 'new_todo' ) {
				$already = mysql_query( "select tid from todos where longdesc='$longdesc' and title='$title'" );
				list( $already ) = mysql_fetch_array( $already );
				if ( !$already ) {
					$query = "insert into todos set owner=$uid,title='$title',public=$sharing,priority=$priority,branch=$branch,team=$team,date=".time().",longdesc='$longdesc'";
					if ( $priority == 0 ) $query .= ",datecompleted=".time();
					$result = mysql_query( $query );
					$tid = mysql_insert_id();
					print '<p style="color:red;">Todo added.</p>';
					$new_todo_post_success = 1;
				}
			} else {
				$query = "update todos set title='$title',public=$sharing,priority=$priority,branch=$branch,team=$team,longdesc='$longdesc'";
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

	if ( $action != 'new_todo' ) {
		$todo = mysql_query( "select * from todos where tid=$tid" );
		$todo = mysql_fetch_array( $todo );
	}
	if ( $action != 'new_todo' && !$todo['title'] ) {
		// tid wasn't in the database
		print '<p style="color:red;">The specified todo doesn\'t seem to be available.</p>';
		main_footer();
		exit;
	}

	if ( $action == 'new_todo' ) { $theirs = 1; unset( $tid ); }
	if ( $todo['owner'] == $uid ) $theirs = 1;

	if ( $uid ) {
		$admin = mysql_query( "select admin from users where uid=$uid" );
		list( $admin ) = mysql_fetch_row( $admin );
		if ( $admin ) $theirs = 1;
	}


	if     ( $todo['priority'] == 0 ) $priority = 'complete';
	elseif ( $todo['priority'] == 1 ) $priority = 'low';
	elseif ( $todo['priority'] == 2 ) $priority = 'med';
	elseif ( $todo['priority'] == 3 ) $priority = 'hi';

	if   ( $todo['public'] == 1 ) $public = 'public';
	else                          $public = 'private';

	$branch = branch_num_name( $todo['branch'] );

	if ( $action == 'new_todo' ) {
		$priority = 'low';
		$public = 'private';
		$team = mysql_query( "select team from users where uid=$uid" );
		list( $team ) = mysql_fetch_row( $team );
	}

	$team = team_num_name( $todo['team'] );

	if ( $action != 'new_todo' ) {
		$developer = mysql_query( 'select username from users where uid='.$todo['owner'] );
		list( $developer ) = mysql_fetch_row( $developer );
	}

	$todo['title'] = strip_tags( $todo['title'], $allow_tags );
	$todo['longdesc'] = strip_tags( $todo['longdesc'], $allow_tags );

?>
<p>&nbsp;</p>
<?php if ( $theirs ) { ?><form method="post" action="single.php?action=<?php if ( $action == 'new_todo' ) print 'new_todo'; else print 'update'; ?>"> <?php } ?>
<table width="90%" border=0 cellpadding=3 cellspacing=0 align="center" bgcolor="#46357c"><tr><td>
<table width="100%" border=0 cellpadding=3 cellspacing=0>
<tr>
	<td align="center" bgcolor="#46357c"><p style="padding:0;margin:0;color:white;font-weight:bold;">
	<?php if ( $theirs ) { ?>
		<input type="text" name="title" maxlength=100 size=50 value="<?=$todo['title'];?>">
	<?php } else {
		print $todo['title'];
	} ?>
	</p></td>
</tr>
<tr>
	<td bgcolor="#dddaec">
		<table width="100%" border=0 cellpadding=5 cellspacing=0>
		<tr>
			<td width="50%" valign="top">
			<p>
				<b>Developer:</b> <?=$developer;?><br>
				<?php if ( $action == 'new_todo' ) { ?>
					<b>Todo (will be) posted:</b> <?=date( "n/j/y", time() );?><br>
				<?php } else { ?>
					<b>Todo posted:</b> <?=date( "n/j/y", $todo['date'] );?><br>
				<?php } ?>
				<b>Team:</b>
				<?php if ( $theirs ) {
					if (!$team) $team = 'None'; ?> 
					<select name="team"><option><?=$team;?></option><?php
					while ( $each = each($teams) ) {
						if ( $each['value'] == $team ) continue;
						print '<option>'.$each['value'].'</option>';
					}
				?></select>
				<?php } else {
					print $team;
				} ?><br>
			</p>
			</td>
			<td>
			<p>
				<b>Priority:</b> 
				<?php if ( $theirs ) { ?>
					<select name="priority"><?php
					if ( $priority == 'hi' ) {
						print '<option>hi</option><option>med</option><option>low</option><option>complete</option>';
					} elseif ( $priority == 'med' ) {
						print '<option>med</option><option>hi</option><option>low</option><option>complete</option>';
					} elseif ( $priority == 'complete' ) {
						print '<option>complete</option><option>low</option><option>med</option><option>hi</option>';
					} else {
						print '<option>low</option><option>med</option><option>hi</option><option>complete</option>';
					}
				?></select>
				<?php } else {
					print "$priority - <img src=\"images/$priority.gif\" width=16 height=16>";
				} ?><br>
				<b>Sharing:</b>
				<?php if ( $theirs ) { ?>
					<select name="sharing"><?php
					if ( $public == 'public' ) {
						print '<option>public</option><option>private</option>';
					} else {
						print '<option>private</option><option>public</option>';
					}
				?></select>
				<?php } else {
					print "$public - <img src=\"images/$public.gif\" width=16 height=16>";
				}
				if ( $team != 'Infrastructure' ) { ?><br>
				<b>Branch:</b>
				<?php if ( $theirs ) {
					if (!$branch) $branch = 'none'; ?>
					<select name="branch"><option><?=$branch;?></option><?php
					while ( $each = each($branches) ) {
						if ( $each['value'] == $branch ) continue;
						print '<option>'.$each['value'].'</option>';
					}
				?></select>
				<?php } else {
					print $branch;
				}
				} # if ( $team != 'Infrastructure' )

				if ( $uid && $uid != $todo['owner'] && $public == 'public' ) { ?>
					<br><a href="index.php?action=grab_todo&tid=<?=$tid;?>"><img src="images/grab.gif" border=0 width=109 height=15></a>
				<?php } ?>
			</p>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<?php if ( $theirs ) { ?>
		<td bgcolor="white" align="center"><textarea name='longdesc' rows=7 cols=55><?=$todo['longdesc'];?></textarea><br>
		<input type="hidden" name="committed" value="1">
		<input type="hidden" name="tid" value="<?=$tid;?>">
		<input type="submit" value="Commit"></td>
	<?php } else { ?>
		<td bgcolor="white"><?=$todo['longdesc'];?><br>
	<?php } ?>
</tr>
</table>
</td></tr></table>
<?php if ( $theirs ) print '</form>'; ?>

<table width="90%" border=0 cellpadding=0 cellspacing=0 align="center"><tr><td>

<?php if ( $uid && ($action != 'new_todo' || $new_todo_post_success) ) { ?>
<div style="float:right;padding:10px 0 5px 5px;">
	<table width=250 border=0 cellpadding=3 cellspacing=0 bgcolor="#46357c"><tr><td>
	<table width="100%" border=0 cellpadding=5 cellspacing=0 bgcolor="white"><tr><td>
		<form method="post" action="single.php?action=post_followup&tid=<?=$tid;?>">
		<p style="font-weight:bold;">Post a Followup!</p>
		<p>
			<textarea cols=40 rows=7 name="followup"></textarea><br>
			<input type="submit" value="Post">
		</p>
		</form>
	</td></tr></table>
	</td></tr></table>
</div>
<?php } ?>

<?php
	if ( $action != 'new_todo' ) {
		// okay, now we get to spit out all the followups.
		$result = mysql_query( "select * from followups where tid=$tid order by date" );
		while ( $fup = mysql_fetch_array( $result ) ) {
			$fuser = mysql_query( 'select username from users where uid='.$fup['uid'] );
			list( $fuser ) = mysql_fetch_row( $fuser );
?>	
			<p style="margin:15px 5px 5px 5px;">Posted by <b><?=$fuser;?></b> on <b><?=date( "n/j/y", $fup['date'] );?></b></p>
			<p style="margin:0 5px 5px 15px"><?=$fup['followup'];?></p>
			<?php
		}
	}

?>

</tr></td></table>

<?php main_footer(); ?>
