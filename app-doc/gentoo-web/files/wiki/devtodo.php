<?php
	include "functions.php";

	main_header( 'Todo by developer' );

	if ( !$devid ) $devid = $uid;
	$username = mysql_query( "select username from users where uid=$devid" );
	list( $username ) = mysql_fetch_row( $username );

?>
<p style="font-size:medium;font-weight:bold;"><?=$username;?>'s uncompleted todos</p>
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
	<td bgcolor="#dddaec"><b>Flags</b></td>
	<td bgcolor="#dddaec"><b>Followups</b></td>
</tr>
<?php
		$result = mysql_query( "select * from todos where owner=$devid order by priority desc,date" );
		while ( $todo = mysql_fetch_array($result) ) {
			if ( $todo['priority'] == 0 || $todo['public'] == 1 ) continue;
			if ( $todo['priority'] == 1 ) {
				$priority = 'low';
			} elseif ( $todo['priority'] == 2 ) {
				$priority = 'med';
			} elseif ( $todo['priority'] == 3 ) {
				$priority = 'hi';
			}
			$fupcount = mysql_query( 'select fid from followups where tid='.$todo['tid'] );
			$fupcount = mysql_num_rows( $fupcount );

			#$flagimgs = '';
			#if ( $todo['public'] == 1 )
			#	$flagimgs = '<img src="images/public.gif" width=16 height=16 alt="public">';
?>
<tr>
	<td><img src="images/<?=$priority;?>.gif" alt="<?=$priority;?>"></td>
	<td><?=date( "n/j/y", $todo['date'] );?></td>
	<td><a href="single.php?tid=<?=$todo['tid'];?>"><?=$todo['title'];?></a></td>
	<td><?=$flagimgs;?></td>
	<td><?=$fupcount;?></td>
</tr>
<?php 
		}
?>
</table>

<p>&nbsp;</p>

<p style="font-size:medium;font-weight:bold;"><?=$username;?>'s completed todos</p>
<table width="95%" border=0 cellpadding=2 cellspacing=2>
<tr>
	<td bgcolor="#dddaec"><b>Title</b></td>
	<td bgcolor="#dddaec"><b>Followups</b></td>
	<td bgcolor="#dddaec"><b>Existed</b></td>
</tr>
<?php
		$result = mysql_query( "select * from todos where owner=$devid and priority=0 order by datecompleted" );
		while ( $todo = mysql_fetch_array($result) ) {

			$fupcount = mysql_query( 'select fid from followups where tid='.$todo['tid'] );
			$fupcount = mysql_num_rows( $fupcount );

			$flagimgs = '';
			if ( $todo['public'] == 1 )
				$flagimgs = '<img src="images/public.gif" width=16 height=16 alt="public">';
?>
<tr>
	<td><a href="single.php?tid=<?=$todo['tid'];?>"><?=$todo['title'];?></a></td>
	<td><?=$fupcount;?></td>
	<td><?=date( "n/j/y", $todo['date'] );?>-<?=date( "n/j/y", $todo['datecompleted'] );?></td>
</tr>
<?php 
		}
?>
</table>

<?php main_footer(); ?>
