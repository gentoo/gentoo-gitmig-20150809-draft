# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome/gnome-1.4-r3.ebuild,v 1.13 2004/04/27 19:05:17 pvdabeel Exp $

S=${WORKDIR}
DESCRIPTION="GNOME 1.4 - merge this package to merge all GNOME base packages"
HOMEPAGE="http://www.gnome.org/"
KEYWORDS="x86 -ppc sparc"
LICENSE="as-is"
SLOT="1.4"
RDEPEND=">=gnome-base/gnome-core-1.4.0.4-r1
	<gnome-base/gnome-applets-2
	<gnome-base/nautilus-2
	<gnome-base/gdm-2.4
	<x11-wm/sawfish-1.2"
