# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/tuareg-mode/tuareg-mode-1.41.2.ebuild,v 1.1 2004/01/30 14:46:34 mattam Exp $

inherit elisp

DESCRIPTION="OCaml mode for emacs"
HOMEPAGE="http://www-rocq.inria.fr/~acohen/tuareg/index.html.en"
SRC_URI="http://www-rocq.inria.fr/~acohen/tuareg/mode/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
DEPEND=">=app-editors/emacs-21.0"

S="${WORKDIR}/${P}"

SITEFILE=50tuareg-mode.el

src_compile () {
	emacs --no-site-file --no-init-file -batch -f batch-byte-compile tuareg.el
}

src_install() {
	elisp-install ${PN} camldebug.el tuareg.el tuareg.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
	dodoc HISTORY COPYING LISEZMOI README
}
