# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/tuareg-mode/tuareg-mode-1.45.5.ebuild,v 1.6 2008/04/28 17:55:09 armin76 Exp $

inherit elisp

DESCRIPTION="An Objective Caml/Camllight mode for Emacs"
HOMEPAGE="http://www-rocq.inria.fr/~acohen/tuareg/index.html.en"
SRC_URI="http://www-rocq.inria.fr/~acohen/tuareg/mode/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

SITEFILE=50${PN}-gentoo.el
DOCS="HISTORY LISEZMOI README"

src_unpack() {
	unpack ${A}
	rm "${S}"/sym-lock.*		# works only with XEmacs
}

src_compile() {
	elisp-comp *.el || die "elisp-comp failed"
}
