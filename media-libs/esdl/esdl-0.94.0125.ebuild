# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/esdl/esdl-0.94.0125.ebuild,v 1.2 2004/02/29 21:26:18 vapier Exp $

DESCRIPTION="Erlang bindings for the SDL library"
HOMEPAGE="http://esdl.sourceforge.net/"
SRC_URI="mirror://sourceforge/esdl/${P}.src.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND=">=dev-lang/erlang-9b
	>=media-libs/libsdl-1.2.4"

src_compile() {
	cp c_src/Makefile{,.orig}
	sed -e "/^CFLAGS.*/s:\\\\$: ${CFLAGS} \\\\:" \
		c_src/Makefile.orig > c_src/Makefile
	make || die
}

src_install() {
	ERLANG_DIR="/usr/lib/erlang/lib/"
	ESDL_DIR="${ERLANG_DIR}/${P}"
	dodir ${ESDL_DIR}

	make install INSTALLDIR=${D}/${ESDL_DIR} || die
	cp include/* ${D}/${ESDL_DIR}/include/ || die
	dosym ${ESDL_DIR} ${ERLANG_DIR}/${PN}
	dodoc Readme license.terms
	mv ${D}/${ESDL_DIR}/doc/ ${D}/usr/share/doc/${PF}/html/
}
