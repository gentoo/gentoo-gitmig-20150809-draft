# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/esdl/esdl-0.94.0125.ebuild,v 1.5 2004/07/14 19:19:52 agriffis Exp $

inherit fixheadtails

DESCRIPTION="Erlang bindings for the SDL library"
HOMEPAGE="http://esdl.sourceforge.net/"
SRC_URI="mirror://sourceforge/esdl/${P}.src.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND=">=dev-lang/erlang-9b
	>=media-libs/libsdl-1.2.4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "/CFLAGS.*=/s:-g -O2:${CFLAGS}:" c_src/Makefile
	ht_fix_file Makefile c_src/Makefile
}

src_compile() {
	emake || die
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
