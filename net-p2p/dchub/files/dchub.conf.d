# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/dchub/files/dchub.conf.d,v 1.2 2004/07/15 00:19:57 agriffis Exp $

# dchub configuration directory
DCHUB_CONF_DIR="/etc/dchub"

# extra options to pass to dchub
# -U, --UID=USERNAME              ask DcHub to change UID after having bind the main port.
# -d, --pscriptdir=DIRECTORY      name of the directory containing perl script.
# -s, --pscriptinit=FILENAME      name of the filename loaded when perl starts.
# -n, --newport=NUMBER            change listening port of the hub. After using
#                                 this option, the new port is stored in the
#                                 database and the option is no more required.
# -f, --forceport=NUMBER          force DCHUB to register a specific Port
# -e, --exprogdir=DIRECTORY       name of the directory containing external programs.
#                                 (NOTE: if a file named 'AUTOSTART' exists in this
#                                 directory, this file contains the name of all
#                                 external programs to start (1 per line)
# -b, --bind=IP                   if the machin have more than one external IP
# -l, --linkdir=DIRECTORY         name of the directory containing plugins.
#                                 (NOTE: if a file named 'AUTOSTART' exists in this
#                                 directory, this file contains the name of all
#                                 plugins to load on start (1 per line)
DCHUB_OPTS="-U nobody"
