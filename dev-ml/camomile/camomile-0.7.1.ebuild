# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/camomile/camomile-0.7.1.ebuild,v 1.4 2008/04/20 14:11:05 maekke Exp $

inherit findlib eutils

EAPI="1"

DESCRIPTION="Camomile is a comprehensive Unicode library for ocaml."
HOMEPAGE="http://camomile.sourceforge.net/"
SRC_URI="mirror://sourceforge/camomile/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="debug +ocamlopt"

DEPEND=">=dev-lang/ocaml-3.07"

pkg_setup() {
	if use ocamlopt && ! built_with_use --missing true dev-lang/ocaml ocamlopt; then
		eerror "In order to build ${PN} with native code support from ocaml"
		eerror "You first need to have a native code ocaml compiler."
		eerror "You need to install dev-lang/ocaml with ocamlopt useflag on."
		die "Please install ocaml with ocamlopt useflag"
	fi
}

src_compile() {
	econf $(use_enable debug)
	emake -j1 byte unidata unimaps charmap_data locale_data || die "failed to build"
	if use ocamlopt; then
		emake -j1 opt || die "failed to build native code"
	fi
}

src_install() {
	dodir /usr/bin
	findlib_src_install DATADIR="${D}/usr/share" BINDIR="${D}/usr/bin"
}
