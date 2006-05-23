# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/tuareg-mode/tuareg-mode-1.46.0.ebuild,v 1.1 2006/05/23 23:45:10 mkennedy Exp $

inherit elisp

DESCRIPTION="Tuareg is a Objective Caml/Camllight mode for Emacs"
HOMEPAGE="http://www-rocq.inria.fr/~acohen/tuareg/index.html.en"
SRC_URI="http://www-rocq.inria.fr/~acohen/tuareg/mode/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
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
