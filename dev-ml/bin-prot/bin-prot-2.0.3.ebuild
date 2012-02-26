# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/bin-prot/bin-prot-2.0.3.ebuild,v 1.2 2012/02/26 13:51:56 aballier Exp $

EAPI=3

inherit findlib eutils multilib

DESCRIPTION="A binary protocol generator"
HOMEPAGE="http://ocaml.janestreet.com/?q=node/13"
SRC_URI="http://www.janestreet.com/ocaml/${P}.tar.gz"

LICENSE="LGPL-2.1-linking-exception"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug doc +ocamlopt"

RDEPEND=">=dev-lang/ocaml-3.12[ocamlopt?]
	dev-ml/findlib
	>=dev-ml/ounit-1.0.2
	>=dev-ml/type-conv-2.3.0"
DEPEND="${RDEPEND}
	>=dev-ml/ounit-1.0.2
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

src_test() {
	LD_LIBRARY_PATH="${S}/_build/lib" emake test || die
}

src_install() {
	findlib_src_install

	dodoc README.txt Changelog || die
	if use doc; then
		dodoc doc/README.pdf || die
	fi
}
