# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/jam-mode/jam-mode-0.1.ebuild,v 1.5 2004/11/01 11:09:33 usata Exp $

inherit elisp

DESCRIPTION="An Emacs major mode for editing Jam files"
HOMEPAGE="http://www.tenfoot.uklinux.net/emacs/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~alpha ~ppc-macos"
IUSE=""
DEPEND=""

SITEFILE=70jam-mode-gentoo.el

src_compile() {
	elisp-compile *.el
}

src_install() {
	elisp-install jam-mode *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}
