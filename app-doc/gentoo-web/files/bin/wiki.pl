#!/usr/bin/perl
#

use DBI;

# EDITME
$sql_user = '##USER##';
$sql_pass = '##PASS##';

unless ( $ARGV[0] =~ /^add$/i || $ARGV[0] =~ /^remove$/i ) {
	print STDERR "\nGentoo Linux dev-wiki admin tool!\n\n\tUsage: wiki.pl <add|remove>\n\n";
	exit;
}

$dbh = DBI->connect( "DBI:mysql:##DB##", $sql_user, $sql_pass ) or die "Can't connect: $DBI::err.\n";

if ( $ARGV[0] =~ /^add$/i ) {
	print "****************\n";
	print "** ADD A USER **\n";
	print "** (dev-wiki) **\n";
	print "****************\n\n";

	print 'username: ';
	chomp( $username = <STDIN> );
	die "Empty username!\n" if $username eq '';

	print 'password: ';
	chomp( $password = <STDIN> );
	die "Empty password!\n" if $password eq '';

	print "\nWould you like this user to be an admin (y/n)? ";
	chomp( $admin = <STDIN> );

	if ( $admin =~ /^y/i ) {
		$admin = 1;
		$admin_word = "yes";
	} else {
		$admin = 0;
		$admin_word = "no";
	}

	print "\nDid I get that right: ($username/$password/admin: $admin_word)? ";
	chomp( $check = <STDIN> );
	die "Okay, try again then.\n" unless $check =~ /^y/i;

	$sth = $dbh->prepare( "insert into ##DB##.users set username='$username',password='$password',admin=$admin" );
	$sth->execute();
	
	print "\nUser $username added.\n";
	exit;
} else {
	print "*******************\n";
	print "** REMOVE A USER **\n";
	print "**    (dev-wiki) **\n";
	print "*******************\n\n";

	print 'username: ';
	chomp( $username = <STDIN> );
	die "Empty username!\n" if $username eq '';

	$sth = $dbh->prepare( "select uid from ##DB##.users where username='$username'" );
	$sth->execute();
	( $uid ) = $sth->fetchrow_array();
	die "$username does not exist!\n" if !$uid;

	print "Are you absolutely sure you want to remove $username\n";
	print "from the database? This will remove all of his/her\n";
	print "todo items and follow-ups past and present. (y/n): ";
	chomp( $check = <STDIN> );
	die "Okaythen. No changes made.\n" unless $check =~ /^y/i;

	$sth = $dbh->prepare( "delete from ##DB##.users where uid=$uid" );
	$sth->execute();
	$sth = $dbh->prepare( "delete from ##DB##.todos where owner=$uid" );
	$sth->execute();
	$sth = $dbh->prepare( "delete from ##DB##.followups where uid=$uid" );
	$sth->execute();

	print "\nWow, sucks to be $username; he's gone.\n";
}

