# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/python-mode/python-mode-4.6.ebuild,v 1.8 2004/09/11 13:52:55 aliz Exp $

inherit elisp

IUSE=""

DESCRIPTION="Python Mode is a major editing mode for the XEmacs and FSF Emacs text editors."
HOMEPAGE="http://www.python.org/emacs/python-mode/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"

DEPEND="virtual/emacs"

src_compile() {
	emacs -batch -eval '(byte-compile-file "python-mode.el")'
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/50python-mode-gentoo.el
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
