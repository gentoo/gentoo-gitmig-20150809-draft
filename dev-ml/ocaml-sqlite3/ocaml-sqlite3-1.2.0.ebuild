# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocaml-sqlite3/ocaml-sqlite3-1.2.0.ebuild,v 1.1 2008/05/12 06:57:12 aballier Exp $

inherit findlib eutils

EAPI="1"

IUSE="doc +ocamlopt"

DESCRIPTION="A package for ocaml that provides access to SQLite databases."
SRC_URI="http://ocaml.info/ocaml_sources/${P}.tar.bz2"
HOMEPAGE="http://ocaml.info/home/ocaml_sources.html#ocaml-sqlite3"

DEPEND=">=dev-lang/ocaml-3.09
	>=dev-db/sqlite-3.3.3"

RDEPEND="${DEPEND}"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"

pkg_setup() {
	if use ocamlopt && ! built_with_use --missing true dev-lang/ocaml ocamlopt; then
		eerror "In order to build ${PN} with native code support from ocaml"
		eerror "You first need to have a native code ocaml compiler."
		eerror "You need to install dev-lang/ocaml with ocamlopt useflag on."
		die "Please install ocaml with ocamlopt useflag"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-0.22.0-destdir.patch"
	epatch "${FILESDIR}/${PN}-0.23.0-noocamlopt.patch"
}

src_compile() {
	econf
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
	dodoc CHANGES README TODO
	use doc && dohtml doc/*
}
