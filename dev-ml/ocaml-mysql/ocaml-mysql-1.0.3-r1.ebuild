# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocaml-mysql/ocaml-mysql-1.0.3-r1.ebuild,v 1.2 2005/08/17 12:51:53 vivo Exp $

inherit findlib eutils

IUSE="doc"

DESCRIPTION="A package for ocaml that provides access to mysql databases."
SRC_URI="http://raevnos.pennmush.org/code/${PN}/${P}.tar.gz"
HOMEPAGE="http://raevnos.pennmush.org/code/ocaml-mysql/index.html"

DEPEND=">=dev-lang/ocaml-3.06
	>=dev-db/mysql-4.0.12"

RDEPEND="$DEPEND"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 ppc"

src_compile()
{
	epatch ${FILESDIR}/${P}-head.patch
	epatch ${FILESDIR}/${P}-shtool-r1.patch
	econf || die "configure failed"
	make all || die "make failed"
	make opt
}

src_install()
{
	findlib_src_preinst
	make install || die

	( use doc ) && dohtml -r doc/html/*
	dodoc META COPYING CHANGES README VERSION
}
