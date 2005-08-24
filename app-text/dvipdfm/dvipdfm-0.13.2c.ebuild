# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/dvipdfm/dvipdfm-0.13.2c.ebuild,v 1.14 2005/08/24 03:49:48 leonardop Exp $

DESCRIPTION="DVI to PDF translator"
SRC_URI="http://gaspra.kettering.edu/dvipdfm/${P}.tar.gz"
HOMEPAGE="http://gaspra.kettering.edu/dvipdfm/"
LICENSE="GPL-2"

KEYWORDS="x86 ppc sparc"
SLOT="0"
IUSE=""

DEPEND="=app-text/tetex-1*
	>=media-libs/libpng-1.2.1
	>=sys-libs/zlib-1.1.4
	!>=app-text/tetex-2
	!app-text/ptex
	!app-text/cstetex"

S=${WORKDIR}/${PN}

src_compile() {
	econf || die
	emake || die
}

src_install () {
	einstall || die

	dodoc AUTHORS ChangeLog Credits INSTALL* NEWS OBTAINING README* TODO

	cp latex-support/dvipdfm.def ${D}/usr/share/doc/${P}/
	cp -pPR doc ${D}/usr/share/doc/${P}/manual
	cp -pPR latex-support ${D}/usr/share/doc/${P}
	dodoc ${FILESDIR}/README.Gentoo
}

pkg_postinst() {
	zcat /usr/share/doc/${P}/README.Gentoo.gz
}
