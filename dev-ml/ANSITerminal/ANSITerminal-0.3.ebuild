# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ANSITerminal/ANSITerminal-0.3.ebuild,v 1.1 2008/01/27 17:52:38 aballier Exp $

EAPI=1

inherit findlib eutils

DESCRIPTION="Module which offers basic control of ANSI compliant terminals"
HOMEPAGE="http://math.umh.ac.be/an/software.php#x4-80007"
SRC_URI="ftp://ftp.umh.ac.be/pub/ftp_san/${P}.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
DEPEND="dev-lang/ocaml"
IUSE="doc +ocamlopt"

pkg_setup() {
	if use ocamlopt && ! built_with_use --missing true dev-lang/ocaml ocamlopt; then
		eerror "In order to build ${PN} with native code support from ocaml"
		eerror "You first need to have a native code ocaml compiler."
		eerror "You need to install dev-lang/ocaml with ocamlopt useflag on."
		die "Please install ocaml with ocamlopt useflag"
	fi
}

src_compile() {
	emake byte || die "Failed to compile bytecode"
	if use ocamlopt; then
		emake opt || die "Failed to compile native code"
	else
		sed -i -e "s/all META/byte META/" Makefile || die "failed to make native code optional"
	fi
	if use doc; then
		emake doc || die "Failed to build documentation"
	fi
}

src_install() {
	findlib_src_install
	dodoc README
	use doc && dohtml ANSITerminal.html/*
}
