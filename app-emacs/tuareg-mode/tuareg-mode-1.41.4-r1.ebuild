# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/tuareg-mode/tuareg-mode-1.41.4-r1.ebuild,v 1.1 2004/05/02 13:29:51 mattam Exp $

inherit elisp

DESCRIPTION="OCaml mode for emacs"
HOMEPAGE="http://www-rocq.inria.fr/~acohen/tuareg/index.html.en"
SRC_URI="http://www-rocq.inria.fr/~acohen/tuareg/mode/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
DEPEND="virtual/emacs"

S="${WORKDIR}/${P}"

SITEFILE=50${PN}-gentoo.el

src_compile () {
	elisp-comp tuareg.el
}

src_install() {
	elisp_src_install
	dodoc HISTORY COPYING LISEZMOI README
}
