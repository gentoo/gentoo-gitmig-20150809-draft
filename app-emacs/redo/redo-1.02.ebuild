# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/redo/redo-1.02.ebuild,v 1.6 2004/11/01 11:28:11 usata Exp $

inherit elisp

DESCRIPTION="Redo/undo system for XEmacs (and GNU emacs)"
HOMEPAGE="http://www.wonderworks.com/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~alpha ~ppc-macos"
IUSE=""

SITEFILE=50redo-gentoo.el

src_compile() {
	elisp-compile *.el
}

src_install() {
	elisp-install redo *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}
