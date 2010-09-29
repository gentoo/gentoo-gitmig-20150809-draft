# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocaml-sqlite3/ocaml-sqlite3-1.5.8.ebuild,v 1.1 2010/09/29 18:29:26 aballier Exp $

EAPI="2"

inherit findlib eutils

IUSE="doc +ocamlopt"

DESCRIPTION="A package for ocaml that provides access to SQLite databases."
SRC_URI="http://ocaml.info/ocaml_sources/${P}.tar.gz"
HOMEPAGE="http://ocaml.info/home/ocaml_sources.html#ocaml-sqlite3"

DEPEND=">=dev-lang/ocaml-3.11[ocamlopt?]
	>=dev-db/sqlite-3.3.3"

RDEPEND="${DEPEND}"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.22.0-destdir.patch"
	epatch "${FILESDIR}/${PN}-0.23.0-noocamlopt.patch"
	epatch "${FILESDIR}/${PN}-1.5.1-werror.patch"
}

src_compile() {
	emake -j1 bytecode || die "make bytecode failed"
	if use ocamlopt; then
		emake -j1 opt || die "make opt failed"
	fi
	if use doc; then
		emake -j1 docs || die "make doc failed"
	fi
}

src_install() {
	findlib_src_preinst
	export OCAMLPATH="${OCAMLFIND_DESTDIR}"
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc Changelog README.txt TODO
	use doc && dohtml doc/*
}
