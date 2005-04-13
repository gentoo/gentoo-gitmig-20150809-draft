# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/coq/coq-7.4.ebuild,v 1.2 2005/04/13 18:38:55 luckyduck Exp $

inherit eutils

DESCRIPTION="Coq is a proof assistant written in O'Caml"
HOMEPAGE="http://coq.inria.fr/"
SRC_URI="ftp://ftp.inria.fr/INRIA/${PN}/V${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE="norealanalysis"

DEPEND=">=dev-lang/ocaml-3.06
!>=dev-lang/ocaml-3.08"

src_compile() {
	local myconf="--prefix /usr \
		--bindir /usr/bin \
		--libdir /usr/lib/coq \
		--mandir /usr/man \
		--emacslib /usr/share/emacs/site-lisp"

	use norealanalysis \
		&& myconf="$myconf --reals" \
		|| myconf="$myconf --reals all"

	has_version ">=dev-lang/ocaml-3.07" && epatch ${FILESDIR}/ocaml-3.07.patch

	./configure $myconf || die

	emake world || die
}

src_install() {
	make COQINSTALLPREFIX=${D} install || die
	dodoc README CREDITS CHANGES
}
