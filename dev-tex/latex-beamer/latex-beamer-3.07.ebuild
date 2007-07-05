# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/latex-beamer/latex-beamer-3.07.ebuild,v 1.4 2007/07/05 11:23:51 pylon Exp $

inherit latex-package elisp-common

DESCRIPTION="LaTeX class for creating presentations using a video projector."
HOMEPAGE="http://latex-beamer.sourceforge.net/"
SRC_URI="mirror://sourceforge/latex-beamer/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

IUSE="doc emacs lyx"

DEPEND="emacs? ( app-emacs/auctex )
	lyx? ( app-office/lyx )
	>=app-text/tetex-3.0"

src_compile() {
	if use emacs ; then
		cd emacs
		elisp-comp beamer.el || die
	fi
}

src_install() {
	insinto /usr/share/texmf-site/tex/latex/beamer
	doins -r base extensions themes || die

	insinto /usr/share/texmf-site/tex/latex/beamer/emulation
	doins emulation/*.sty || die

	if use lyx ; then
		insinto /usr/share/lyx/layouts
		doins lyx/layouts/beamer.layout || die
		insinto /usr/share/lyx/examples
		doins lyx/examples/* || die
		doins solutions/*/*.lyx || die
	fi

	if use emacs ; then
		insinto /usr/share/emacs/site-lisp/auctex/style
		doins emacs/beamer.el* || die
	fi

	dodoc AUTHORS ChangeLog FILES TODO README
	if use doc ; then
		insinto /usr/share/doc/${PF}
		doins doc/* || die

		insinto /usr/share/doc/${PF}
		doins -r examples emulation/examples solutions || die
	fi
}
