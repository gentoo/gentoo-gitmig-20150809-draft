# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/tuareg-mode/tuareg-mode-1.44.3.ebuild,v 1.2 2005/04/21 18:44:14 blubb Exp $

inherit elisp

DESCRIPTION="OCaml mode for emacs"
HOMEPAGE="http://www-rocq.inria.fr/~acohen/tuareg/index.html.en"
SRC_URI="http://www-rocq.inria.fr/~acohen/tuareg/mode/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE=""

DEPEND="virtual/emacs"

SITEFILE=50${PN}-gentoo.el

src_compile() {
	einfo "Bytecode compilation not available"
}

src_install() {
	elisp_src_install
	dodoc HISTORY LISEZMOI README
}
