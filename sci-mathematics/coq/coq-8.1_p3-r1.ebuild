# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/coq/coq-8.1_p3-r1.ebuild,v 1.2 2008/12/31 03:41:46 mr_bones_ Exp $

EAPI="2"

inherit eutils multilib

RESTRICT="strip installsources"

MY_PV="${PV/_p/pl}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Coq is a proof assistant written in O'Caml"
HOMEPAGE="http://coq.inria.fr/"
SRC_URI="ftp://ftp.inria.fr/INRIA/${PN}/V${MY_PV}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="norealanalysis ide debug +ocamlopt"

DEPEND=">=dev-lang/ocaml-3.10[ocamlopt?]
		>=dev-ml/camlp5-5.09[ocamlopt?]
		ide? ( >=dev-ml/lablgtk-2.10.1[ocamlopt?] )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}/${P}-noocamlopt.patch"
	epatch "${FILESDIR}/${P}-cmxa-install.dpatch"
}

src_configure() {
	local myconf="--prefix /usr \
		--bindir /usr/bin \
		--libdir /usr/$(get_libdir)/coq \
		--mandir /usr/man \
		--emacslib /usr/share/emacs/site-lisp \
		--coqdocdir /usr/$(get_libdir)/coq/coqdoc
		--camlp5dir +camlp5"

	use debug && myconf="--debug $myconf"
	use norealanalysis && myconf="$myconf --reals no"
	use norealanalysis || myconf="$myconf --reals all"

	if use ide; then
		use ocamlopt && myconf="$myconf --coqide opt"
		use ocamlopt || myconf="$myconf --coqide byte"
	else
		myconf="$myconf --coqide no"
	fi
	use ocamlopt || myconf="$myconf -byte-only"

	./configure $myconf || die "configure failed"

	if use ide; then
		labldir=/usr/$(get_libdir)/ocaml/lablgtk2
		sed -i -e "s|BYTEFLAGS=|BYTEFLAGS=-I ${labldir} |" Makefile
		sed -i -e "s|OPTFLAGS=|OPTFLAGS=-I ${labldir} |" Makefile
		sed -i -e "s|COQIDEFLAGS=.*|COQIDEFLAGS=-thread -I ${labldir}|" Makefile
	fi
}

src_compile() {
	emake -j1 || die "make failed"
}

src_install() {
	emake COQINSTALLPREFIX="${D}" install || die
	dodoc README CREDITS CHANGES

	if use ide; then
		domenu "${FILESDIR}/coqide.desktop"
	fi
}
