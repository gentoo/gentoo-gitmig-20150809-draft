# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/coccinelle/coccinelle-0.2.5.ebuild,v 1.1 2011/05/08 21:09:48 slyfox Exp $

EAPI="2"

inherit multilib

DESCRIPTION="Program matching and transformation engine"
HOMEPAGE="http://coccinelle.lip6.fr/"
SRC_URI="http://coccinelle.lip6.fr/distrib/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc +ocamlopt python"

RDEPEND="python? ( dev-lang/python )
	>=dev-lang/ocaml-3.10[ocamlopt?]"
DEPEND="${RDEPEND}
	doc? ( virtual/latex-base
		|| ( dev-texlive/texlive-latexextra app-text/ptex ) )"

src_configure() {
	# non-autoconf
	./configure \
		--prefix=/usr \
		$(use ocamlopt || echo "--no-opt") \
		$(use_with python) \
		|| die
	sed -i "s:^LIBDIR=.*:LIBDIR=/usr/$(get_libdir)/ocaml/stublibs/:" Makefile.config
	sed -i "s:^SHAREDIR=.*:SHAREDIR=/usr/libexec/${PN}/:" Makefile.config
	sed -i "s:^MANDIR=.*:MANDIR=/usr/share/man/:" Makefile.config
}

src_compile() {
	emake depend || die
	emake || die
	if use doc ; then
		VARTEXFONTS="${T}"/fonts emake docs || die
	fi
	if use ocamlopt ; then
		emake opt || die
	fi
}

src_test() {
	source env.sh # needed for built in-place python plugin
	./spatch standard.h -parse_c -dir tests/ || die
	yes | ./spatch -iso_file standard.iso -macro_file_builtins standard.h -testall || die
	if use ocamlopt ; then
		./spatch.opt -iso_file standard.iso -macro_file_builtins standard.h -testall ||	die
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc authors.txt bugs.txt changes.txt credits.txt readme.txt
	use doc && dodoc docs/manual/*.pdf
	export STRIP_MASK='*/coccinelle/spatch'
}
