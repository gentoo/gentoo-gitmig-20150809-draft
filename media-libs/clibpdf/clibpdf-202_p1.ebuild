# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/clibpdf/clibpdf-202_p1.ebuild,v 1.1 2004/08/07 03:59:34 robbat2 Exp $

inherit flag-o-matic eutils

DESCRIPTION="ANSI C Library for Direct PDF Generation"
HOMEPAGE="http://www.fastio.com/"
SRC_URI_FN="clibpdf${PV/_p/r}.tar.gz"
SRC_URI="http://www.fastio.com/${SRC_URI_FN}
		mirror://gentoo/${P}-buildfix.patch.gz
		http://dev.gentoo.org/~robbat2/distfiles/${P}-buildfix.patch.gz"
LICENSE="clibpdf"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/libc sys-devel/gcc"
MY_PN="ClibPDF"
S=${WORKDIR}/${MY_PN}

src_unpack() {
	unpack ${SRC_URI_FN}
	epatch ${DISTDIR}/${P}-buildfix.patch.gz
}

src_compile() {
	append-flags -Wall -DLinux
	cd ${S}/source
	emake -f Makefile.Linux lib shlib || die "emake failed"
}

src_install() {
	dodoc ${S}/doc/* ${S}/LICENSE.pdf
	insinto /usr/share/${PN}/fonts
	doins ${S}/fonts/*
	dodir /usr/lib /usr/include
	cd ${S}/source
	make -f Makefile.Linux LIB_DIR="${D}/usr/lib" INCLUDE_DIR="${D}/usr/include" install shinstall
}
