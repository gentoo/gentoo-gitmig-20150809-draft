# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/giblib/giblib-1.2.4.ebuild,v 1.4 2004/11/11 00:24:24 vapier Exp $

inherit toolchain-funcs

DESCRIPTION="Giblib, graphics library"
HOMEPAGE="http://www.linuxbrit.co.uk/giblib/"
SRC_URI="http://www.linuxbrit.co.uk/downloads/${P}.tar.gz"

LICENSE="|| ( as-is BSD )"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE=""

DEPEND=">=media-libs/imlib2-1.0.3
	>=media-libs/freetype-2.0"

src_compile() {
	$(tc-getCC) ${FILESDIR}/imlib-x-test.c `imlib2-config --libs` `imlib2-config --cflags` \
		|| die "You need to re-emerge Imlib2 with USE=X"

	econf || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	rm -rf ${D}/usr/doc
	dodoc README AUTHORS ChangeLog TODO
}
