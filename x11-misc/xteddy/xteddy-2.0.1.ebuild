# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xteddy/xteddy-2.0.1.ebuild,v 1.7 2007/07/22 03:15:28 dberkholz Exp $

DESCRIPTION="A cuddly teddy bear (or other image) for your X desktop"
HOMEPAGE="http://www.itn.liu.se/~stegu/xteddy/"
SRC_URI="http://www.itn.liu.se/~stegu/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="x11-libs/libXext
		x11-libs/libSM
		media-libs/imlib"

DEPEND="${RDEPEND}
		x11-proto/xextproto"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS README ChangeLog NEWS xteddy.README
}
