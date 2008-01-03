# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/coq/coq-8.1_p3.ebuild,v 1.3 2008/01/03 17:41:59 aballier Exp $

inherit eutils multilib

EAPI="1"

IUSE="norealanalysis ide debug +ocamlopt"

RESTRICT="strip"

MY_PV="${PV/_p/pl}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Coq is a proof assistant written in O'Caml"
HOMEPAGE="http://coq.inria.fr/"
SRC_URI="ftp://ftp.inria.fr/INRIA/${PN}/V${MY_PV}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND="|| ( ( >=dev-lang/ocaml-3.10 >=dev-ml/camlp5-5.01 ) <dev-lang/ocaml-3.10 )
>=dev-lang/ocaml-3.08
ide? ( >=dev-ml/lablgtk-2.2.0 )"

S="${WORKDIR}/${MY_P}"

coq_need_ocamlopt() {
	if use ocamlopt && ! built_with_use --missing true $1 ocamlopt; then
		eerror "In order to build ${PN} with native code support from ocaml"
		eerror "You first need to have a native code ocaml compiler and the related libraries."
		eerror "You need to install $1 with ocamlopt useflag on."
		die "Please install $1 with ocamlopt useflag"
	fi
}


pkg_setup() {
	coq_need_ocamlopt 'dev-lang/ocaml'
	use ide && coq_need_ocamlopt 'dev-ml/lablgtk'
	has_version '>=dev-lang/ocaml-3.10.0' && coq_need_ocamlopt 'dev-ml/camlp5'
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-noocamlopt.patch"
	epatch "${FILESDIR}/${P}-cmxa-install.dpatch"
}

src_compile() {
	local myconf="--prefix /usr \
		--bindir /usr/bin \
		--libdir /usr/$(get_libdir)/coq \
		--mandir /usr/man \
		--emacslib /usr/share/emacs/site-lisp \
		--coqdocdir /usr/$(get_libdir)/coq/coqdoc"

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

	emake -j1 alldepend || die "make failed"
	emake worldnodep || die "make failed"
}

src_install() {
	emake COQINSTALLPREFIX="${D}" install || die
	dodoc README CREDITS CHANGES

	if use ide; then
		domenu "${FILESDIR}/coqide.desktop"
	fi
}
