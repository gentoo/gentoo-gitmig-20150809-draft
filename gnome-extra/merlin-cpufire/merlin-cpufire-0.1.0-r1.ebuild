# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/merlin-cpufire/merlin-cpufire-0.1.0-r1.ebuild,v 1.5 2004/02/22 20:53:28 agriffis Exp $

DESCRIPTION="Gnome applet that displays CPU usage as burning fire"
HOMEPAGE="http://nitric.com/freeware"
SRC_URI="ftp://ftp.ibiblio.org/pub/packages/desktops/gnome/sources/merlin-cpufire/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"

RDEPEND="gnome-base/gnome-core
	<gnome-base/libgtop-2"
DEPEND="${RDEPEND}"

src_compile() {
	mv Makefile Makefile~
	# include libgtop in cppFlags
	sed <Makefile~ >Makefile -e 's|cppFlags = ${shell gnome-config --cflags glib gnome gnomeui gnorba}|cppFlags = ${shell gnome-config --cflags glib gnome gnomeui gnorba libgtop}|'
	make prefix=${D}/usr etcdir=${D}/etc || die
}

src_install () {
	make prefix=${D}/usr etcdir=${D}/etc install
}
