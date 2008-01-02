# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/camlp5/camlp5-5.07.ebuild,v 1.1 2008/01/02 19:18:59 aballier Exp $

inherit multilib findlib eutils

EAPI="1"

DESCRIPTION="A preprocessor-pretty-printer of ocaml"
HOMEPAGE="http://pauillac.inria.fr/~ddr/camlp5/"
SRC_URI="http://pauillac.inria.fr/~ddr/camlp5/distrib/src/${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc +ocamlopt"

DEPEND=">=dev-lang/ocaml-3.09"
RDEPEND="${DEPEND}"

pkg_setup() {
	if use ocamlopt && ! built_with_use --missing true dev-lang/ocaml ocamlopt; then
		eerror "In order to build ${PN} with native code support from ocaml"
		eerror "You first need to have a native code ocaml compiler."
		eerror "You need to install dev-lang/ocaml with ocamlopt useflag on."
		die "Please install ocaml with ocamlopt useflag"
	fi
}

src_compile() {
	./configure \
		-prefix /usr \
	    -bindir /usr/bin \
		-libdir /usr/$(get_libdir)/ocaml \
		-mandir /usr/share/man || die "configure failed"

	emake -j1 || die "emake failed"
	if use ocamlopt; then
		emake -j1 opt || die "Compiling native code programs failed"
		emake -j1 opt.opt || die "Compiling native code programs failed"
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
