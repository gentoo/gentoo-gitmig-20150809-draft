# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header

A=""
S=${WORKDIR}
DESCRIPTION="GNOME 1.2.4 -- Install this package first, it sets up the environment and depends on everything else"
HOMEPAGE="http://www.gnome.org/"

RDEPEND="
	=gnome-base/mc-4.5.51
	=gnome-base/gal-0.2.2
	=gnome-base/oaf-0.6.1
	=gnome-base/ORBit-0.5.4
	=gnome-base/gnome-vfs-0.4.2
	=gnome-base/gconf-0.11
	=gnome-base/gdk-pixbuf-0.9.0
	=gnome-base/libgtop-1.0.10
	=gnome-base/gnome-core-1.2.4
	=gnome-base/gnome-libs-1.2.8
	=gnome-base/libunicode-0.4
	=gnome-base/bonobo-0.28
	=gnome-base/libxml-1.8.10-r1
	=gnome-base/glibwww-0.2
	=gnome-base/gnome-applets-1.2.4
	=gnome-base/control-center-1.2.2-r1
	=gnome-base/gtkhtml-0.7
	=gnome-base/gnome-print-0.25
	=gnome-base/libghttp-1.0.7
	=gnome-base/libglade-0.15
"
src_install() {
	insinto /etc/env.d
	doins ${FILESDIR}/90gnome
	#this file adds /opt/gnome stuff to the path
	exeinto /usr/X11R6/bin/wm
	doexe ${FILESDIR}/gnome
}

