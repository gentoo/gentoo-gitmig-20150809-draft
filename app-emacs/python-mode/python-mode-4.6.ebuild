# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/python-mode/python-mode-4.6.ebuild,v 1.4 2004/02/15 08:04:22 dholm Exp $

inherit elisp

IUSE=""

DESCRIPTION="Python Mode is a major editing mode for the XEmacs and FSF Emacs text editors."
HOMEPAGE="http://www.python.org/emacs/python-mode/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ppc"

DEPEND="virtual/emacs"

S="${WORKDIR}/${P}"

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
