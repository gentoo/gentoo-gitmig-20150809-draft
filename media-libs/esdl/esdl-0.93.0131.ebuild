# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/esdl/esdl-0.93.0131.ebuild,v 1.1 2003/02/17 19:01:57 vapier Exp $

DESCRIPTION="Erlang bindings for the SDL library" 
SRC_URI="mirror://sourceforge/esdl/${P}.src.tar.gz"
HOMEPAGE="http://esdl.sourceforge.net/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=dev-lang/erlang-9b
	>=media-libs/libsdl-1.2.4"

src_compile() {
	make CFLAGS="${CFLAGS}" || die
}

src_install() {
	ESDL_DIR="/usr/lib/erlang/lib/${P}"
	dodir ${ESDL_DIR}
	make install INSTALLDIR=${D}/${ESDL_DIR} || die
	dodoc Readme
}
