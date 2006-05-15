# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/develock/develock-0.27.ebuild,v 1.1 2006/05/15 19:40:24 mkennedy Exp $

inherit elisp

IUSE=""

DESCRIPTION="An Emacs minor mode for highlighting broken formatting rules"
HOMEPAGE="http://www.jpl.org/ftp/pub/elisp/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~sparc ~amd64 ~ppc ~x86"

DEPEND="virtual/emacs"

SITEFILE=50develock-gentoo.el

src_compile() {
	elisp-comp *.el
}

src_install() {
	elisp-install ${PN} *.{el,elc}
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}
