# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header

A=""
S=${WORKDIR}
DESCRIPTION="GNOME env-1.0 -- Install this package first, it sets up the environment and depends on everything else"
HOMEPAGE="http://www.gnome.org/"


src_install() {
	insinto /etc/env.d
	doins ${FILESDIR}/90gnome
	exeinto /usr/X11R6/bin/wm
	doins ${FILESDIR}/gnome
}

