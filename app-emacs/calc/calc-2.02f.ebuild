# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/calc/calc-2.02f.ebuild,v 1.1 2006/03/05 23:35:38 mkennedy Exp $

inherit elisp eutils

DESCRIPTION="Advanced calculator and mathematical tool within Emacs"
HOMEPAGE="http://www.gnu.org/software/emacs/calc.html"
SRC_URI="mirror://gnu/calc/${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

SITEFILE="50calc-gentoo.el"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-emacs-21.patch
	epatch ${FILESDIR}/${P}-info-dir.patch
}

src_compile() {
	emake compile info || die
}

src_install() {
	elisp-install ${PN} calc*.el calc*.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
	doinfo calc.info*
	dodoc README README.prev
}
