# Copyright 2002 Maik Schreiber
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/merlin-cpufire/merlin-cpufire-0.1.0.ebuild,v 1.1 2002/06/19 01:08:02 rphillips Exp $

DESCRIPTION="Gnome applet that displays CPU usage as burning fire"
HOMEPAGE="http://nitric.com/freeware"
LICENSE="GPL-2"
RDEPEND="gnome-base/gnome-core gnome-base/libgtop"
DEPEND="${RDEPEND}"
SRC_URI="ftp://ftp.ibiblio.org/pub/packages/desktops/gnome/sources/merlin-cpufire/${P}.tgz"

src_compile() {
	mv Makefile Makefile~
	# include libgtop in cppFlags
	sed <Makefile~ >Makefile -e 's|cppFlags = ${shell gnome-config --cflags glib gnome gnomeui gnorba}|cppFlags = ${shell gnome-config --cflags glib gnome gnomeui gnorba libgtop}|'
	make prefix=${D}/usr etcdir=${D}/etc || die
}

src_install () {
	make prefix=${D}/usr etcdir=${D}/etc install
}
