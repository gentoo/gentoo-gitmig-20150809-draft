# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/xrdb-mode/xrdb-mode-2.31.ebuild,v 1.8 2007/02/18 12:03:33 mabi Exp $

inherit elisp

DESCRIPTION="An Emacs major mode for editing X resource database files"
HOMEPAGE="http://www.python.org/emacs/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""
DEPEND="virtual/emacs"

SITEFILE=70xrdb-mode-gentoo.el

src_compile() {
	emacs --no-site-file --no-init-file -batch -f batch-byte-compile *.el
}

src_install() {
	elisp-install xrdb-mode *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}
