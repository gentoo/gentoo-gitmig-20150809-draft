# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocaml-sqlite3/ocaml-sqlite3-0.22.0.ebuild,v 1.1 2007/08/31 07:23:45 aballier Exp $

inherit findlib eutils

IUSE="doc"

DESCRIPTION="A package for ocaml that provides access to SQLite databases."
SRC_URI="http://ocaml.info/ocaml_sources/${P}.tar.bz2"
HOMEPAGE="http://ocaml.info/home/ocaml_sources.html#ocaml-sqlite3"

DEPEND=">=dev-lang/ocaml-3.09
	>=dev-db/sqlite-3.3.3"

RDEPEND="${DEPEND}"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-destdir.patch"
}

src_compile() {
	econf
	emake -j1 bytecode || die "make bytecode failed"
	emake -j1 opt || die "make opt failed"
	if use doc; then
		emake -j1 docs || die "make doc failed"
	fi
}

src_install() {
	findlib_src_preinst
	export OCAMLPATH="${OCAMLFIND_DESTDIR}"
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc CHANGES README TODO
	use doc && dohtml doc/*
}
