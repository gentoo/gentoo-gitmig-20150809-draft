# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/camlp5/camlp5-6.02.1.ebuild,v 1.1 2010/12/07 15:12:12 aballier Exp $

EAPI="2"

inherit multilib findlib

DESCRIPTION="A preprocessor-pretty-printer of ocaml"
HOMEPAGE="http://pauillac.inria.fr/~ddr/camlp5/"
SRC_URI="http://pauillac.inria.fr/~ddr/camlp5/distrib/src/${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="doc +ocamlopt"

DEPEND=">=dev-lang/ocaml-3.10[ocamlopt?]"
RDEPEND="${DEPEND}"

src_configure() {
	./configure \
		-prefix /usr \
	    -bindir /usr/bin \
		-libdir /usr/$(get_libdir)/ocaml \
		-mandir /usr/share/man || die "configure failed"
}

src_compile(){
	emake || die "emake failed"
	if use ocamlopt; then
		emake  opt || die "Compiling native code programs failed"
		emake  opt.opt || die "Compiling native code programs failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	# findlib support
	insinto "$(ocamlfind printconf destdir)/${PN}"
	doins etc/META || die "failed to install META file for findlib support"

	use doc && dohtml -r doc/*

	dodoc CHANGES DEVEL ICHANGES README UPGRADING MODE
}
