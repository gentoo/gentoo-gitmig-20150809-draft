# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocamlsdl/ocamlsdl-0.7.1.ebuild,v 1.5 2012/02/05 18:33:08 armin76 Exp $

inherit findlib

DESCRIPTION="OCaml SDL Bindings"

HOMEPAGE="http://ocamlsdl.sourceforge.net"
SRC_URI="mirror://sourceforge/ocamlsdl/${P}.tar.gz"
LICENSE="LGPL-2"

SLOT="0"
KEYWORDS="ppc x86"
IUSE="doc opengl truetype" #noimage nomixer

DEPEND=">=dev-lang/ocaml-3.04
>=media-libs/libsdl-1.2
opengl? ( >=dev-ml/lablgl-0.98 )
>=media-libs/sdl-mixer-1.2
>=media-libs/sdl-image-1.2
truetype? ( >=media-libs/sdl-ttf-2.0 )"

src_compile() {
	myconf=""
	if use opengl; then
		destdir=`ocamlfind printconf destdir`
		lablgldir=`find ${destdir} -name "lablgl" -or -name "lablGL"`
		if [ -z "${lablgldir}" ]; then
			destdir=`ocamlc -where`
			lablgldir=`find ${destdir} -name "lablgl" -or -name "lablGL"`
		fi

		if [ ! -z "${lablgldir}" ]; then
			myconf="--with-lablgldir=${lablgldir}"
		fi
	fi

	#use noimage && myconf="${myconf} --without-sdl-image"
	#use nomixer && myconf="${myconf} --without-sdl-mixer"

	econf $myconf \
		`use_enable truetype sdl-ttf` \
		|| die
	emake all || die
}

src_install() {
	findlib_src_install

	dodoc AUTHORS NEWS README
	doinfo doc/*.info*

	if use doc; then
		dohtml doc/html/*
	fi
}
