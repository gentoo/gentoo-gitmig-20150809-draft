# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gif2png/gif2png-2.5.1.ebuild,v 1.11 2005/09/11 01:53:51 vanquirius Exp $

DESCRIPTION="Converts images from gif format to png format"
HOMEPAGE="http://catb.org/~esr/gif2png/"
SRC_URI="http://catb.org/~esr/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc ~ppc-macos ppc64 sparc x86"
IUSE=""

DEPEND="media-libs/libpng"

src_compile() {
	econf --prefix=/usr || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dodir ${D}/usr/bin
	make \
		DESTDIR=${D} \
		install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
