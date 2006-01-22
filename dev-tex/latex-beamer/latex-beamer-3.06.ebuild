# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/latex-beamer/latex-beamer-3.06.ebuild,v 1.1 2006/01/22 14:26:24 ehmsen Exp $

inherit latex-package elisp-common

DESCRIPTION="LaTeX class for creating presentations using a video projector."
HOMEPAGE="http://latex-beamer.sourceforge.net/"
SRC_URI="mirror://sourceforge/latex-beamer/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="emacs"

DEPEND=">=dev-tex/pgf-1.00
	>=dev-tex/xcolor-2.00
	emacs? ( app-emacs/auctex )
	!>=app-text/tetex-3.0"

src_compile() {
	if use emacs ; then
		cd emacs
		elisp-comp beamer.el || die
	fi
}

src_install() {
	insinto /usr/share/texmf/tex/latex/beamer
	doins -r base extensions solutions themes || die

	insinto /usr/share/texmf/tex/latex/beamer/emulation
	doins emulation/*.sty || die

	insinto /usr/share/doc/${PF}
	doins -r examples emulation/examples || die

	if has_version 'app-office/lyx' ; then
		doins -r lyx || die
	fi

	if use emacs ; then
		insinto /usr/share/emacs/site-lisp/auctex/style
		doins emacs/beamer.el* || die
	fi

	dodoc AUTHORS ChangeLog FILES TODO README
	insinto /usr/share/doc/${PF}
	doins doc/* || die
}
