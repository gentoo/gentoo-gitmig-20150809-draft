<?php
	include "functions.php";
	main_header( 'Todo details' );
	$todo = mysql_query( "select * from todos where tid=$tid" );
	$todo = mysql_fetch_array( $todo );
	if ( !$todo['tid'] ) {
		// tid wasn't in the database
		print '<p style="color:red;">Something bad happened: The specified todo doesn\'t seem to be available. Hpoefully, you know what\'s going on</p>';
		main_footer();
		exit;
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

	$developer = mysql_query( 'select username from users where uid='.$todo['owner'] );
	list( $developer ) = mysql_fetch_row( $developer );

	if ( $priority == 'complete' ) $public = 'complete';
		
?>
<p>&nbsp;</p>
<table width="90%" border=0 cellpadding=3 cellspacing=0 align="center" bgcolor="#46357c"><tr><td>
<table width="100%" border=0 cellpadding=3 cellspacing=0>
<tr>
	<td align="center" bgcolor="#46357c"><p style="padding:0;margin:0;color:white;font-weight:bold;"><?=$todo['title'];?></p></td>
</tr>
<tr>
	<td bgcolor="#dddaec">
		<table width="100%" border=0 cellpadding=5 cellspacing=0>
		<tr>
			<td width="50%" valign="top">
			<p>
				<b>Developer:</b> <?=$developer;?><br>
				<b>Todo posted:</b> <?=date( "n/j/y", $todo['date'] );?><br>
			</p>
			</td>
			<td>
			<p>
				<b>Priority:</b> <?=$priority;?> - <img src="images/<?=$priority;?>.gif" width=16 height=16 alt="<?=$priority;?>"><br>
				<b>Sharing:</b> <?=$public;?> - <img src="images/<?=$public;?>.gif" width=16 height=16 alt="<?=$public;?>"><br>
				<?php if ( $public == 'public' && $uid && $uid != $todo['owner'] ) { ?>
				<a href="index.php?action=grab_todo&tid=<?=$todo['tid'];?>"><img src="images/grab.gif" border=0 alt="grab todo"></a>
				<?php } ?>
			</p>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td bgcolor="white"><?=$todo['longdesc'];?></td>
</tr>
</table>
</td></tr></table>

<table width="90%" border=0 cellpadding=0 cellspacing=0 align="center"><tr><td>
	<?php if ( $uid ) { // they're logged in. let's let them post a followup. ?>
	<div width=200 style="float:right;">
		<p>&nbsp;</p>
		<table width=200 border=0 cellpadding=3 cellspacing=0 bgcolor="#46357c"><tr><td>
		<table width="100%" border=0 cellpadding=5 cellspacing=0 bgcolor="white"><tr><td>
			<form method="post" action="single.php?action=post_followup&tid=<?=$todo['tid'];?>">
			<p style="font-weight:bold;">Post a Followup!</p>
			<p>
				<textarea cols=20 rows=5 name="followup"></textarea><br>
				<input type="submit" value="Post">
			</p>
			</form>
		</td></tr></table>
		</td></tr></table>
	</div>
	<?php } // end followup block

	// okay, now we get to spit out all the followups.
	$result = mysql_query( 'select * from followups where tid='.$todo['tid'].' order by date desc' );
	while ( $fup = mysql_fetch_array( $result ) ) {
		$fuser = mysql_query( 'select username from users where uid='.$fup['uid'] );
		list( $fuser ) = mysql_fetch_row( $fuser );
?>
	<p style="margin:15px 5px 5px 5px;">Posted by <b><?=$fuser;?></b> on <b><?=date( "n/j/y", $fup['date'] );?></b></p>
	<p style="margin:0 5px 5px 15px"><?=$fup['followup'];?></p>
<?php
	}
?>
</td></tr></table>
	
<?php main_footer(); ?>
