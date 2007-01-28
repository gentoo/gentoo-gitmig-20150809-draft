# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/analog/analog-1.29.ebuild,v 1.11 2007/01/28 03:58:48 genone Exp $

inherit elisp

IUSE=""

DESCRIPTION="Monitor lists of files or command output"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki.pl?action=browse&id=MattHodges&oldid=MatthewHodges"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"

DEPEND="virtual/emacs"

SITEFILE=50analog-gentoo.el

src_compile() {
	emacs --batch -f batch-byte-compile --no-site-file --no-init-file *.el
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
}

pkg_postinst() {
	elisp-site-regen
	elog "Please see ${SITELISP}/${PN}/analog.el for the complete documentation."
}

pkg_postrm() {
	elisp-site-regen
}
