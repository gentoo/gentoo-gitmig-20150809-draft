#!/usr/bin/perl

use File::Path;
use File::Copy;
use File::Glob ":glob";
use POSIX ":sys_wait_h";

$timeout = 60;

%{ENV}->{"MOZILLA_FIVE_HOME"}="/usr/lib/mozilla";
%{ENV}->{"LD_LIBRARY_PATH"}="/usr/lib/mozilla";

umask 022;

if ( -f "/usr/lib/mozilla/regxpcom" )
{
    # remove all of the old files
    rmtree("/usr/lib/mozilla/chrome/overlayinfo");
    unlink </usr/lib/mozilla/chrome/*.rdf>;
    unlink("/usr/lib/mozilla/component.reg");
    unlink("/usr/lib/mozilla/components/compreg.dat");
    unlink("/usr/lib/mozilla/components/xpti.dat");

    # create a new clean path
    mkpath("/usr/lib/mozilla/chrome/overlayinfo");

    # rebuild the installed-chrome.txt file from the installed
    # languages
    if ( -f "/usr/lib/mozilla/chrome/lang/installed-chrome.txt" ) {
	rebuild_lang_files();
    }

    # run regxpcom
    $pid = fork();

    # I am the child.
    if ($pid == 0) {
	exec("/usr/lib/mozilla/regxpcom > /dev/null 2> /dev/null");
    }
    # I am the parent.
    else {
	my $timepassed = 0;
	do {
	    $kid = waitpid($pid, &WNOHANG);
	    sleep(1);
	    $timepassed++;
        } until $kid == -1 || $timepassed > $timeout;

	# should we kill?
	if ($timepassed > $timeout) {
	    kill (9, $pid);
	    # kill -9 can leave threads hanging around
	    system("/usr/bin/killall -9 regxpcom");
	}
    }

    # and run regchrome for good measure
    $pid = fork();

    # I am the child.
    if ($pid == 0) {
	exec("/usr/lib/mozilla/regchrome > /dev/null 2> /dev/null");
    }
    # I am the parent.
    else {
	my $timepassed = 0;
	do {
	    $kid = waitpid($pid, &WNOHANG);
	    sleep(1);
	    $timepassed++;
        } until $kid == -1 || $timepassed > $timeout;

	# should we kill?
	if ($timepassed > $timeout) {
	    kill (9, $pid);
	    # kill -9 can leave threads hanging around
	    system("/usr/bin/killall -9 regchrome");
	}
    }

}


sub rebuild_lang_files {
    unlink("/usr/lib/mozilla/chrome/installed-chrome.txt");

    open (OUTPUT, "+>", "/usr/lib/mozilla/chrome/installed-chrome.txt")||
	die("Failed to open installed-chrome.txt: $!\n");

    copy("/usr/lib/mozilla/chrome/lang/installed-chrome.txt",
	 \*OUTPUT);

    foreach (bsd_glob("/usr/lib/mozilla/chrome/lang/lang-*.txt")) {
	copy($_, \*OUTPUT);
    }

    copy("/usr/lib/mozilla/chrome/lang/default.txt",
	 \*OUTPUT);
}
