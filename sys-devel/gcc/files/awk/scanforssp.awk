# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author:  Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/files/awk/scanforssp.awk,v 1.1 2003/12/28 21:46:24 azarah Exp $

function printn(string)
{
	system("echo -n \"" string "\"")
}

function einfo(string)
{
	system("echo -e \" \\e[32;01m*\\e[0m " string "\"")
}

function einfon(string)
{
	system("echo -ne \" \\e[32;01m*\\e[0m " string "\"")
}

function ewarn(string)
{
	system("echo -e \" \\e[33;01m*\\e[0m " string "\"")
}

function ewarnn(string)
{
	system("echo -ne \" \\e[33;01m*\\e[0m " string "\"")
}
	
function eerror(string)
{
	system("echo -e \" \\e[31;01m*\\e[0m " string "\"")
}

# assert --- assert that a condition is true. Otherwise exit.
# This is from the gawk info manual.
function assert(condition, string)
{
	if (! condition) {
		printf("%s:%d: assertion failed: %s\n",
			FILENAME, FNR, string) > "/dev/stderr"
		_assert_exit = 1
		exit 1
	}
}

# system() wrapper that normalize return codes ...
function dosystem(command,		ret)
{
	ret = 0
 
	ret = system(command)
	if (ret == 0)
		return 1
	else
		return 0
}


BEGIN {

	DIRCOUNT = 0
	# Add the two default library paths
	DIRLIST[1] = "/lib"
	DIRLIST[2] = "/usr/lib"

	# Walk /etc/ld.so.conf line for line and get any library paths
	pipe = "cat /etc/ld.so.conf 2>/dev/null | sort"
	while(((pipe) | getline ldsoconf_data) > 0) {

		if (ldsoconf_data !~ /^[[:space:]]*#/) {

			if (ldsoconf_data == "") continue

			# Remove any trailing comments
			sub(/#.*$/, "", ldsoconf_data)
			# Remove any trailing spaces
			sub(/[[:space:]]+$/, "", ldsoconf_data)
	
			split(ldsoconf_data, nodes, /[:,[:space:]]/)

			# Now add the rest from ld.so.conf
			for (x in nodes) {

				sub(/=.*/, "", nodes[x])
				sub(/\/$/, "", nodes[x])

				if (nodes[x] == "") continue

				CHILD = 0

				# Drop the directory if its a child directory of
				# one that was already added ...
				for (y in DIRLIST) {

					if (nodes[x] ~ "^" DIRLIST[y]) {
					
						CHILD = 1
						break
					}
				}

				if (CHILD) continue
		
				DIRLIST[++DIRCOUNT + 2] = nodes[x]
			}
		}
	}

	close(pipe)

# We have no guarantee that ld.so.conf have more library paths than
# the default, and its better scan files only in /lib and /usr/lib
# than not at all ...
#	if (DIRCOUNT == 0) {
#		eerror("Could not read from /etc/ld.so.conf!")
#		exit 1
#	}

	# Correct DIRCOUNT, as we already added /lib and /usr/lib
	DIRCOUNT += 2

	# Add all the dirs in $PATH
	split(ENVIRON["PATH"], TMPPATHLIST, ":")
	count = asort(TMPPATHLIST, PATHLIST)
	for (x = 1;x <= count;x++) {

		ADDED = 0
	
		for (dnode in DIRLIST)
			if (PATHLIST[x] == DIRLIST[dnode])
				ADDED = 1

		if (ADDED)
			continue
			
		DIRLIST[++DIRCOUNT] = PATHLIST[x]
	}
	
	FOUND_SSP = 0
	GCCLIBPREFIX = "/usr/lib/gcc-lib/"
	
	for (x = 1;x <= DIRCOUNT;x++) {

		# Do nothing if the target dir is gcc's internal library path
		if (DIRLIST[x] ~ GCCLIBPREFIX) continue

		einfo("  Scanning " DIRLIST[x] "...")

		FOUND = 0

		pipe = "find " DIRLIST[x] "/ -type f -perm -1 -maxdepth 90 2>/dev/null"
		while ((((pipe) | getline scan_files) > 0) && (!FOUND)) {

			# Do nothing if the file is located in gcc's internal lib path
			if (scan_files ~ GCCLIBPREFIX) continue

			scan_file_pipe = "readelf -s " scan_files " 2>/dev/null"
#			while ((((scan_file_pipe) | getline scan_data) > 0) && (!FOUND)) {
			while (((getline scan_data < (scan_files)) > 0) && (!FOUND)) {

				if (scan_data ~ /__guard@GCC/) {

					ewarn("    Found files containing '__guard@GCC'!")
					FOUND = 1
					FOUND_SSP = 1
					break
				}
			}

#			close(scan_file_pipe)
			close(scan_files)
		}

		close(pipe)
	}

	if (FOUND_SSP)
		exit(1)
	else
		exit(0)
}


# vim:ts=4
