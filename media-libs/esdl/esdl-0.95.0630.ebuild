# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/esdl/esdl-0.95.0630.ebuild,v 1.1 2005/07/02 22:38:02 vapier Exp $

inherit fixheadtails

DESCRIPTION="Erlang bindings for the SDL library"
HOMEPAGE="http://esdl.sourceforge.net/"
SRC_URI="mirror://sourceforge/esdl/${P}.src.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-lang/erlang-9b
	>=media-libs/libsdl-1.2.4"

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
	addpredict /usr/lib/erlang/lib
	ERLANG_DIR="/usr/lib/erlang/lib"
	ESDL_DIR="${ERLANG_DIR}/${P}"
	dodir ${ESDL_DIR}
	make install INSTALLDIR="${D}"/${ESDL_DIR} || die "make install"
}
