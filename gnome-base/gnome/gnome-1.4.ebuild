# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header

A=""
S=${WORKDIR}
DESCRIPTION="GNOME 1.4 - merge this package to merge all GNOME base packages"
HOMEPAGE="http://www.gnome.org/"

DEPEND="=gnome-base/gnome-env-1.0
	=gnome-base/ORBit-0.5.8
        =gnome-base/libxml-1.8.13
        =gnome-base/oaf-0.6.5
        =gnome-base/gnome-libs-1.2.13
        =gnome-base/gdk-pixbuf-0.11.0
        =gnome-base/gnome-print-0.29
        =gnome-base/control-center-1.4.0.1
	=gnome-base/gnome-vfs-1.0
	=gnome-base/gal-0.8
	=gnome-base/gconf-1.0.0
        =gnome-base/bonobo-1.0.4
        =gnome-base/gconf-1.0.0
	=gnome-base/glibwww-0.2-r1
	=gnome-base/gtkhtml-0.9.2
        =gnome-base/libglade-0.16-r1
        =gnome-base/libghttp-1.0.9
        =gnome-base/gnome-core-1.4.0.4
        =gnome-libs/ammonite-1.0.2
        =gnome-libs/medusa-0.5.1
        =gnome-apps/nautilus-1.0.3
        =gnome-base/gnome-applets-1.4.0.1
        =gnome-base/scrollkeeper-0.2"

src_install() {
	dosym gnome-session /opt/gnome/bin/gnome
}

