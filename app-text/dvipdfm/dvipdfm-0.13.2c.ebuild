# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/dvipdfm/dvipdfm-0.13.2c.ebuild,v 1.5 2002/08/16 02:42:01 murphy Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Dvipdfm is a DVI to PDF translator."
SRC_URI="http://gaspra.kettering.edu/dvipdfm/${P}.tar.gz"
HOMEPAGE="http://gaspra.kettering.edu/dvipdfm/"
KEYWORDS="x86 ppc sparc sparc64"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=app-text/tetex-1.0.7
	>=media-libs/libpng-1.2.1
	>=sys-libs/zlib-1.1.4"

src_compile() {
	./configure --host=${CHOST} \
		--prefix=/usr \
		--bindir=/usr/bin \
		--datadir=/usr/share \
		--mandir=/usr/share/man || die

	emake || die
}

src_install () {
	make prefix=${D}/usr \
		bindir=${D}/usr/bin \
		datadir=${D}/usr/share \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	dodoc AUTHORS COPYING ChangeLog Credits INSTALL* NEWS OBTAINING README* TODO

	cp latex-support/dvipdfm.def ${D}/usr/share/doc/${P}/
	cp -a doc ${D}/usr/share/doc/${P}/manual
	cp -a latex-support ${D}/usr/share/doc/${P}
	dodoc ${FILESDIR}/README.Gentoo
}

pkg_postinst() {
	zcat /usr/share/doc/${P}/README.Gentoo.gz
}
