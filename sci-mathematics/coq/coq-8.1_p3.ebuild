# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/coq/coq-8.1_p3.ebuild,v 1.2 2007/12/19 20:08:01 aballier Exp $

inherit eutils multilib

IUSE="norealanalysis ide debug"

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
		myconf="$myconf --coqide opt"
	else
		myconf="$myconf --coqide no"
	fi

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
