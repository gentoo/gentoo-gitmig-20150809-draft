# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocamlsdl/ocamlsdl-0.6.3.ebuild,v 1.1 2004/02/12 00:00:30 mattam Exp $

DESCRIPTION="OCaml SDL Bindings"

HOMEPAGE="http://ocamlsdl.sourceforge.net"
SRC_URI="mirror://sourceforge/ocamlsdl/${P}.tar.bz2"
LICENSE="LGPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/ocaml-3.04
>=media-libs/libsdl-1.2
>=dev-ml/lablgl-0.98
>=media-libs/sdl-mixer-1.2
>=media-libs/sdl-image-1.2
>=media-libs/sdl-ttf-2.0"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} all install || die
	doinfo doc/*.info*
}
