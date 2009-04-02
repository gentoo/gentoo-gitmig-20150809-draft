# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/freeimage/freeimage-3.11.0.ebuild,v 1.4 2009/04/02 23:07:43 nyhm Exp $

inherit toolchain-funcs multilib

MY_PN=FreeImage
MY_P=${MY_PN}${PV//.}
DESCRIPTION="Image library supporting many formats"
HOMEPAGE="http://freeimage.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip
	doc? ( mirror://sourceforge/${PN}/${MY_P}.pdf )"

LICENSE="|| ( GPL-2 FIPL-1.0 )"
SLOT="0"
KEYWORDS="~amd64 ppc ~x86"
IUSE="cxx doc"

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}/${MY_PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/^CC =/s:gcc:$(tc-getCC) ${CFLAGS} -Wall:" \
		-e "/^CXX =/s:g++:$(tc-getCXX) ${CXXFLAGS} -Wall:" \
		-e "/^AR = /s:ar:$(tc-getAR):" \
		-e "/^INCDIR = /s:/usr/include:${D}/usr/include:" \
		-e "/^INSTALLDIR = /s:/usr/lib:${D}/usr/$(get_libdir):" \
		-e '/^COMPILERFLAGS =/s:-O3:-fPIC:' \
		-e "/\$(CC) -s /s: -s : ${LDFLAGS} :" \
		Makefile.{gnu,fip} \
		|| die "sed failed"
}

src_compile() {
	emake -f Makefile.gnu || die "emake failed"
	if use cxx ; then
		emake -f Makefile.fip || die "emake fip failed"
	fi
}

src_install() {
	dodir /usr/include /usr/$(get_libdir)
	emake -f Makefile.gnu install || die "emake install failed"
	if use cxx ; then
		emake -f Makefile.fip install || die "emake install fip failed"
	fi
	dodoc README.linux Whatsnew.txt
	use doc && dodoc "${DISTDIR}"/${MY_P}.pdf
}
