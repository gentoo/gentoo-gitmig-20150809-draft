# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cheesetracker/cheesetracker-0.9.9.ebuild,v 1.2 2004/05/31 22:44:01 kugelfang Exp $

inherit 64-bit

DESCRIPTION="A clone of Impulse Tracker with some extensions and a built-in sample editor; uses QT"
HOMEPAGE="http://cheesetronic.sf.net/"
SRC_URI="mirror://sourceforge/cheesetronic/${P}.tar.gz"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

IUSE="jack"

RDEPEND="jack? ( virtual/jack )
	=dev-libs/libsigc++-1.2*
	>=x11-libs/qt-3.0"

DEPEND="${RDEPEND}
	>=dev-util/scons-0.94-r2"

src_unpack() {
	unpack ${A}
	64-bit && epatch ${FILESDIR}/${P}-64bit-clean.diff
}

src_compile() {
	scons || die
}

src_install() {
	dodir /usr/bin
	scons prefix=${D}/usr install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO docs/*.txt
}
