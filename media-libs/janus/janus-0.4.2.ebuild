# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/janus/janus-0.4.2.ebuild,v 1.10 2004/07/14 19:50:06 agriffis Exp $

DESCRIPTION="A UI and widget library which employs an extensible XML like data structure and provides an abstract instance of a UI"
SRC_URI="ftp://victor.worldforge.org/pub/worldforge/libs/janus/${P}.tar.bz2"
HOMEPAGE="http://www.worldforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "
IUSE=""

DEPEND=">=dev-libs/libsigc++-1.0*
	>=media-libs/libsdl-1.2.3-r1"

src_compile() {

	econf || die
	emake || die

}

src_install() {

	make DESTDIR=${D} install || die

}
