# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/postgresql-ocaml/postgresql-ocaml-1.4.6.ebuild,v 1.2 2008/05/21 16:00:23 dev-zero Exp $

inherit findlib

IUSE=""

DESCRIPTION="A package for ocaml that provides access to PostgreSQL databases."
SRC_URI="http://ocaml.info/ocaml_sources/${P}.tar.bz2"
HOMEPAGE="http://ocaml.info/home/ocaml_sources.html#toc9"

DEPEND=">=dev-lang/ocaml-3.07
>=virtual/postgresql-server-7.3"
RDEPEND=">=dev-lang/ocaml-3.06"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 ~ppc"

src_compile()
{
	emake CFLAGS=-I/usr/include/postgresql/pgsql
}

src_install()
{
	findlib_src_preinst
	make DESTDIR=${D} install || die

	if use doc; then
		for dir in examples/*
		do
		  docinto $dir
		  dodoc $dir/*
		done
	fi

	dodoc INSTALL AUTHORS VERSION
}
