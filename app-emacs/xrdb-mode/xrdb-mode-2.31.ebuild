# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/xrdb-mode/xrdb-mode-2.31.ebuild,v 1.1 2003/09/10 07:42:50 mkennedy Exp $

inherit elisp

DESCRIPTION="An Emacs major mode for editing X resource database files"
HOMEPAGE="http://www.python.org/emacs/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/emacs"
S=${WORKDIR}/${P}

SITEFILE=70xrdb-mode-gentoo.el

src_compile() {
	emacs --no-site-file --no-init-file -batch -f batch-byte-compile *.el
}

src_install() {
	elisp-install xrdb-mode *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}
