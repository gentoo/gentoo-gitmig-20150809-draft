# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/coq/coq-8.1_p4.ebuild,v 1.2 2009/01/12 02:45:19 darkside Exp $

EAPI="2"

inherit eutils multilib

RESTRICT="strip installsources"

MY_PV="${PV/_p/pl}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Coq is a proof assistant written in O'Caml"
HOMEPAGE="http://coq.inria.fr/"
SRC_URI="http://coq.inria.fr/V${MY_PV}/files/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc ~x86"
IUSE="norealanalysis gtk debug +ocamlopt"

DEPEND=">=dev-lang/ocaml-3.10[ocamlopt?]
		>=dev-ml/camlp5-5.09[ocamlopt?]
		gtk? ( >=dev-ml/lablgtk-2.10.1[ocamlopt?] )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-8.1_p3-noocamlopt.patch"
	epatch "${FILESDIR}/${PN}-8.1_p3-cmxa-install.dpatch"
}

src_configure() {
	ocaml_lib=`ocamlc -where`
	local myconf="--prefix /usr \
		--bindir /usr/bin \
		--libdir /usr/$(get_libdir)/coq \
		--mandir /usr/share/man \
		--emacslib /usr/share/emacs/site-lisp \
		--coqdocdir /usr/$(get_libdir)/coq/coqdoc
		--camlp5dir ${ocaml_lib}/camlp5
		--lablgtkdir ${ocaml_lib}/lablgtk2"

	use debug && myconf="--debug $myconf"
	use norealanalysis && myconf="$myconf --reals no"
	use norealanalysis || myconf="$myconf --reals all"

	if use gtk; then
		use ocamlopt && myconf="$myconf --coqide opt"
		use ocamlopt || myconf="$myconf --coqide byte"
	else
		myconf="$myconf --coqide no"
	fi
	use ocamlopt || myconf="$myconf -byte-only"

	./configure $myconf || die "configure failed"
}

src_compile() {
	emake -j1 || die "make failed"
}

src_install() {
	emake COQINSTALLPREFIX="${D}" install || die
	dodoc README CREDITS CHANGES

	use gtk && domenu "${FILESDIR}/coqide.desktop"
}
