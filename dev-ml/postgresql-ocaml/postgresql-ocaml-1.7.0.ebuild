# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/postgresql-ocaml/postgresql-ocaml-1.7.0.ebuild,v 1.1 2007/08/23 08:31:37 aballier Exp $

inherit findlib

IUSE="examples"

DESCRIPTION="A package for ocaml that provides access to PostgreSQL databases."
SRC_URI="http://ocaml.info/ocaml_sources/${P}.tar.bz2"
HOMEPAGE="http://ocaml.info/home/ocaml_sources.html#toc9"

DEPEND=">=dev-lang/ocaml-3.09
	>=dev-db/postgresql-7.3"
RDEPEND="${DEPEND}"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

src_install()
{
	findlib_src_preinst
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS VERSION

	if use examples; then
		for dir in examples/*
		do
		  docinto $dir
		  dodoc $dir/*
		done
	fi
}
