# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/camlzip/camlzip-1.01-r1.ebuild,v 1.3 2007/11/10 14:22:03 aballier Exp $

inherit findlib eutils

IUSE=""

DESCRIPTION="Compressed file access ML library (ZIP, GZIP and JAR)"
HOMEPAGE="http://cristal.inria.fr/~xleroy/software.html#camlzip"
SRC_URI="http://caml.inria.fr/distrib/bazar-ocaml/${P}.tar.gz"

SLOT="1"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ppc"

DEPEND=">=dev-lang/ocaml-3.04 \
		>=sys-libs/zlib-1.1.3"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-Makefile-findlib.patch"
	sed -e "s/VERSION/${PV}/" "${FILESDIR}/META" >> META
}

src_compile() {
	emake all || die "Failed at compilation step !!!"
	emake allopt || die "Failed at ML compilation step !!!"
}

src_install() {
	findlib_src_install

	dodoc README
}
