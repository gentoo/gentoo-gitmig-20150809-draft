# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header

A=""
S=${WORKDIR}
DESCRIPTION="GNOME 1.4.2 -- Install this package first, it sets up the environment and depends on everything else"
HOMEPAGE="http://www.gnome.org/"

RDEPEND="
        =gnome-base/ORBit-0.5.7
        =gnome-base/libxml-1.8.11
        =gnome-base/oaf-0.6.4
        =gnome-base/gnome-libs-1.2.12
        =gnome-base/gdk-pixbuf-0.9.0-r1
        =gnome-base/gnome-print-0.25-r1
        =gnome-base/gnome-libs-1.2.12
        =gnome-base/control-center-1.2.4
        =gnome-base/bonobo-0.37
        =gnome-base/gconf-0.50
        =gnome-base/libglade-0.16
        =gnome-base/libghttp-1.0.9
        =gnome-base/gnome-core-1.3.1
        =gnome-libs/ammonite-0.8.6
        =gnome-libs/medusa-0.3.2
        =gnome-apps/nautilus-0.8.2
        =gnome-base/gnome-applets-1.3.1
        =gnome-base/scrollkeeper-0.1.2"

src_install() {
	insinto /etc/env.d
	doins ${FILESDIR}/90gnome
	#this file adds /opt/gnome stuff to the path
	exeinto /usr/X11R6/bin/wm
	doexe ${FILESDIR}/gnome
}

