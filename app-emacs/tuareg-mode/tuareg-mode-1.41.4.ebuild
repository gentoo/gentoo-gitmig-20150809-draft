# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/tuareg-mode/tuareg-mode-1.41.4.ebuild,v 1.1 2004/03/31 19:28:52 mkennedy Exp $

inherit elisp

DESCRIPTION="OCaml mode for emacs"
HOMEPAGE="http://www-rocq.inria.fr/~acohen/tuareg/index.html.en"
SRC_URI="http://www-rocq.inria.fr/~acohen/tuareg/mode/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
DEPEND="virtual/emacs"

S="${WORKDIR}/${P}"

SITEFILE=50tuareg-mode.el

src_compile () {
	elisp-comp tuareg.el
}

src_install() {
	elisp-install ${PN} camldebug.el tuareg.el tuareg.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
	dodoc HISTORY COPYING LISEZMOI README
}
