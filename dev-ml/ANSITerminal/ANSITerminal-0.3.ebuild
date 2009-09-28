# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ANSITerminal/ANSITerminal-0.3.ebuild,v 1.2 2009/09/28 16:21:37 betelgeuse Exp $

EAPI="2"

inherit findlib eutils

DESCRIPTION="Module which offers basic control of ANSI compliant terminals"
HOMEPAGE="http://math.umh.ac.be/an/software.php#x4-80007"
SRC_URI="ftp://ftp.umh.ac.be/pub/ftp_san/${P}.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND=">=dev-lang/ocaml-3.10.2[ocamlopt?]"
IUSE="doc +ocamlopt"

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
	dodoc README || die
	use doc && dohtml ANSITerminal.html/*
}
