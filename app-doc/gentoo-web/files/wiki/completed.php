<?php
	include "functions.php";
	main_header( 'Completed todo listing' );
?>
<p style="font-size:medium;font-weight:bold;">Completed todos</p>
<table width="95%" border=0 cellpadding=2 cellspacing=2>
<tr>
	<td bgcolor="#dddaec"><b>Developer</b></td>
	<td bgcolor="#dddaec"><b>Title</b></td>
	<td bgcolor="#dddaec"><b>Section</b></td>
	<td bgcolor="#dddaec"><b>Followups</b></td>
	<td bgcolor="#dddaec"><b>Existed</b></td>
</tr>
<?php
		$result = mysql_query( "select * from todos where priority=0 order by date desc" );
		while ( $todo = mysql_fetch_array($result) ) {
			$fupcount = mysql_query( 'select fid from followups where tid='.$todo['tid'] );
			$fupcount = mysql_num_rows( $fupcount );

			$ownername = mysql_query( 'select username from users where uid='.$todo['owner'] );
			list( $ownername ) = mysql_fetch_row( $ownername );

			$team = team_num_name( $todo['team'] );
			$branch = branch_num_name( $todo['branch'] );
?>
<tr>
	<td><?=$ownername;?></td>
	<td><a href="single.php?tid=<?=$todo['tid'];?>"><?=$todo['title'];?></a></td>
	<td><?=$team.'-'.$branch;?>
	<td><?=$fupcount;?></td>
	<td><?=date( "n/j/y", $todo['date'] );?>-<?=date( "n/j/y", $todo['datecompleted'] );?></td>
</tr>
<?php
		}
?>
</table>

<?php main_footer(); ?>
