# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author:  Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/files/awk/getlibdirs.awk,v 1.1 2002/11/24 01:00:51 azarah Exp $

function einfo(string)
{
	system("echo -e \" \\e[32;01m*\\e[0m " string "\"")
}

function ewarn(string)
{
	system("echo -e \" \\e[33;01m*\\e[0m " string "\"")
}

function eerror(string)
{
	system("echo -e \" \\e[31;01m*\\e[0m " string "\"")
}


BEGIN {

	while((getline ldsoconf_data < ("/etc/ld.so.conf")) > 0) {

		if (ldsoconf_data !~ /[[:space:]]*#/) {

			if (ldsoconf_data == "") continue
	
			split(ldsoconf_data, nodes, /[:,[:space:]]/)

			DIRLIST[1] = "/lib"
			DIRLIST[2] = "/usr/lib"

			for (x in nodes) {

				sub(/=.*/, "", nodes[x])
				sub(/\/$/, "", nodes[x])

				if (nodes[x] == "") continue
		
				DIRLIST[++i + 2] = nodes[x]
			}
		}
	}

	close("/etc/ld.so.conf")

	pipe = "/usr/bin/python -c 'import portage; print portage.settings[\"CHOST\"];'"
	(pipe) | getline CHOST
	close(pipe)

	GCCLIB = "/usr/lib/gcc-lib/" CHOST

	sub(/\/$/, "",  GCCLIB)

	pipe = "gcc -dumpversion"
	(pipe) | getline NEWVER
	close(pipe)
	
	for (x in DIRLIST) {
		
		if (DIRLIST[x] ~ GCCLIB) continue

		einfo("Scanning " DIRLIST[x] "...")

		pipe = "ls -1 " DIRLIST[x] "/*.la 2>/dev/null"
		while (((pipe) | getline la_files) > 0) {

			CHANGED = 0

			while ((getline la_data < (la_files)) > 0) {

				if (gsub(GCCLIB "/" OLDVER "/", GCCLIB "/" NEWVER "/", la_data) > 0)
					CHANGED = 1

				if (gsub(GCCLIB "/" OLDVER "[[:space:]]", GCCLIB "/" NEWVER " ", la_data) > 0)
					CHANGED = 1
			}

			close(la_files)

			if (CHANGED) {

				ewarn("FIXING: " la_files)

				while ((getline la_data < (la_files)) > 0) {

					gsub(GCCLIB "/" OLDVER "/", GCCLIB "/" NEWVER "/", la_data)
					gsub(GCCLIB "/" OLDVER "[[:space:]]", GCCLIB "/" NEWVER " ", la_data)

					print la_data >> (la_files ".new")
				}

				close(la_files)

				system("mv -f " la_files ".new " la_files)
			}
		}

		close(pipe)
	}
}

