# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/lwt/lwt-1.1.0.ebuild,v 1.3 2009/06/17 07:14:08 aballier Exp $

EAPI=2

inherit findlib eutils

DESCRIPTION="Cooperative light-weight thread library for OCaml"
SRC_URI="http://ocsigen.org/download/${P}.tar.gz"
HOMEPAGE="http://ocsigen.org/lwt"

IUSE="doc +ocamlopt"

DEPEND=">=dev-lang/ocaml-3.10[ocamlopt?]
	>=dev-ml/ocaml-ssl-0.4.0"

RDEPEND="${DEPEND}
	!<www-servers/ocsigen-1.1"

SLOT="0"
LICENSE="LGPL-2.1 LGPL-2.1-linking-exception"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"

src_compile() {
	# ocamlbuild is stupid and fails parallel make if it does not exist...
	mkdir _build
	emake OCAMLBUILD="ocamlbuild -byte-plugin" META byte || die "make failed"
	if use ocamlopt ; then
		emake opt || die "failed to build native code version"
	fi
	if use doc ; then
		emake doc || die "failed to build the documentation"
	fi
}

src_install() {
	findlib_src_preinst
	emake DESTDIR="${OCAMLFIND_DESTDIR}" install || die "install failed"
	dodoc CHANGES README
	if use doc; then
		dohtml _build/lwt.docdir/*.html
	fi
}
