# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/esdl/esdl-0.96.0626.ebuild,v 1.3 2006/12/04 00:50:34 opfer Exp $

inherit fixheadtails multilib

DESCRIPTION="Erlang bindings for the SDL library"
HOMEPAGE="http://esdl.sourceforge.net/"
SRC_URI="mirror://sourceforge/esdl/${P}.src.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc x86"
IUSE=""

DEPEND=">=dev-lang/erlang-9b
	>=media-libs/libsdl-1.2.5"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i "/CFLAGS.*=/s:-g -O2 -funroll-loops -Wall -ffast-math:${CFLAGS}:" c_src/Makefile
	ht_fix_file Makefile c_src/Makefile
}

src_compile() {
	emake || die
}

src_install() {
	addpredict /usr/$(get_libdir)/erlang/lib
	ERLANG_DIR="/usr/$(get_libdir)/erlang/lib"
	ESDL_DIR="${ERLANG_DIR}/${P}"
	dodir ${ESDL_DIR}
	make install INSTALLDIR="${D}"/${ESDL_DIR} || die "make install"
}
