# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/coq/coq-8.0_beta.ebuild,v 1.1 2004/04/02 21:02:45 mattam Exp $

IUSE="norealanalysis debug"

DESCRIPTION="Coq is a proof assistant written in O'Caml"
HOMEPAGE="http://coq.inria.fr/"
SRC_URI="ftp://ftp.inria.fr/INRIA/${PN}/V${PV/_/}/${P/_/}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND=">=dev-lang/ocaml-3.06"

S="${WORKDIR}/${P/_/}"

src_compile() {
	local myconf="--prefix /usr \
		--bindir /usr/bin \
		--libdir /usr/lib/coq \
		--mandir /usr/man \
		--emacslib /usr/share/emacs/site-lisp"

	use debug && myconf="--debug $myconf"
	use norealanalysis && myconf="$myconf --reals"
	use norealanalysis || myconf="$myconf --reals all"

	./configure $myconf || die

	emake world || die
}

src_install() {
	make COQINSTALLPREFIX=${D} install || die
	dodoc README CREDITS CHANGES LICENSE
}
