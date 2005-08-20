# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/redo/redo-1.02.ebuild,v 1.9 2005/08/20 19:27:30 grobian Exp $

inherit elisp

DESCRIPTION="Redo/undo system for XEmacs (and GNU emacs)"
HOMEPAGE="http://www.wonderworks.com/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc-macos x86"
IUSE=""

SITEFILE=50redo-gentoo.el

src_compile() {
	elisp-compile *.el
}

src_install() {
	elisp-install redo *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}
