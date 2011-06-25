# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/sexplib/sexplib-5.2.1.ebuild,v 1.1 2011/06/25 18:56:22 aballier Exp $

EAPI=3

inherit findlib eutils multilib

DESCRIPTION="Library for automated conversion of OCaml-values to and from S-expressions"
HOMEPAGE="http://www.ocaml.info/home/ocaml_sources.html"
SRC_URI="http://www.janestreet.com/ocaml/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug doc +ocamlopt"

RDEPEND=">=dev-lang/ocaml-3.12[ocamlopt?]
	>=dev-ml/type-conv-2.3.0"
DEPEND="${RDEPEND}
	doc? ( virtual/latex-base dev-texlive/texlive-latexextra )"

oasis_use_enable() {
	echo "--override $2 `use $1 && echo \"true\" || echo \"false\"`"
}

src_configure() {
	./configure --prefix usr \
		--libdir /usr/$(get_libdir) \
		--destdir "${D}" \
		$(oasis_use_enable debug debug) \
		$(oasis_use_enable ocamlopt is_native) \
		|| die
}

src_compile() {
	emake || die
	if use doc ; then
		cd "${S}/doc"
		pdflatex README || die
		pdflatex README || die
	fi
}

src_install() {
	findlib_src_install

	dodoc README Changelog || die
	if use doc; then
		dodoc doc/README.pdf || die
	fi
}
