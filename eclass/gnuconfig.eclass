# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/gnuconfig.eclass,v 1.4 2003/02/16 04:26:21 vapier Exp $
#
# Author: Will Woods <wwoods@gentoo.org>
#
# This eclass updates config.guess and config.sub. This is useful if 
# configure dies from misguessing your canonical system name (CHOST).

ECLASS=gnuconfig
INHERITED="$INHERITED $ECLASS"

newdepend sys-devel/automake

DESCRIPTION="Based on the ${ECLASS} eclass"

# Copy the newest available config.{guess|sub} on the system over any old 
# ones in the source dir
gnuconfig_update() {
	local configsubs_dir="$(gnuconfig_findnewest)"
	local sub
	local f
	einfo "Using GNU config files from ${configsubs_dir}"
	for sub in config.sub config.guess ; do 
		for f in `find ${S} -name "${sub}"`; do
			einfo "Updating ${f/$S\//}"
			cp -f ${configsubs_dir}/${sub} ${f}
		done
	done
}

# this searches the standard locations for the newest config.{sub|guess}, and
# returns the directory where they can be found.
gnuconfig_findnewest() {
	local locations="/usr/share/automake-1.6/config.sub \
                         /usr/share/automake-1.5/config.sub \
                         /usr/share/automake-1.4/config.sub \
                         /usr/share/libtool/config.sub"
	grep -s '^timestamp' ${locations} | sort -n -t\' -k2 | tail -1 | sed 's,/config.sub:.*$,,'
}
