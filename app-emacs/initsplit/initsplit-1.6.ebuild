# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/initsplit/initsplit-1.6.ebuild,v 1.1 2004/11/18 02:55:12 mkennedy Exp $

inherit elisp

DESCRIPTION="Split customizations into different files"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki?InitSplit"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="virtual/emacs"

SITEFILE=50initsplit-gentoo.el

src_compile() {
	elisp_src_compile
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}
