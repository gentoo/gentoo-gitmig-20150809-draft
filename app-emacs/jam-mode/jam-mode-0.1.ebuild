# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/jam-mode/jam-mode-0.1.ebuild,v 1.1 2003/09/10 06:19:31 mkennedy Exp $

inherit elisp

DESCRIPTION="An Emacs major mode for editing Jam files"
HOMEPAGE="http://www.tenfoot.uklinux.net/emacs/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/emacs"
S=${WORKDIR}/${P}

SITEFILE=70jam-mode-gentoo.el

src_compile() {
	emacs --no-site-file --no-init-file -batch -f batch-byte-compile *.el
}

src_install() {
	elisp-install jam-mode *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}
