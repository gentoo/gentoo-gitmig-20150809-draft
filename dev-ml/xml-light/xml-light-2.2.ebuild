# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/xml-light/xml-light-2.2.ebuild,v 1.1 2011/12/11 18:58:07 maksbotan Exp $

EAPI=3

inherit eutils multilib

DESCRIPTION="Minimal Xml parser and printer for OCaml"
HOMEPAGE="http://tech.motion-twin.com/xmllight.html"
SRC_URI="http://tech.motion-twin.com/zip/${P}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="dev-lang/ocaml
	doc? ( dev-ml/ocaml-doc )"
RDEPEND="dev-lang/ocaml"

S="${WORKDIR}/${PN}"

src_compile() {
	emake || die
}

src_install() {
	dodir /usr/$(get_libdir)/ocaml
	emake INSTALLDIR="${D}"/usr/$(get_libdir)/ocaml install || die
	dodoc  README
	if use doc; then
		emake doc
		dohtml doc/*
	fi
}
