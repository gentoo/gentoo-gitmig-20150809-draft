# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/crypt++/crypt++-2.91.ebuild,v 1.7 2005/01/01 13:41:50 eradicator Exp $

inherit elisp

IUSE=""

DESCRIPTION="Handle all sorts of compressed and encrypted files"
HOMEPAGE="http://freshmeat.net/projects/crypt++/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~sparc"

DEPEND="virtual/emacs"

SITEFILE=50crypt++-gentoo.el

src_compile() {
	emacs --batch -f batch-byte-compile --no-site-file --no-init-file *.el
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}

pkg_postinst() {
	elisp-site-regen
	einfo "Please see ${SITELISP}/${PN}/crypt++.el for the complete documentation."
}

pkg_postrm() {
	elisp-site-regen
}
