# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/crypt++/crypt++-2.91.ebuild,v 1.1 2002/11/01 02:52:01 mkennedy Exp $

inherit elisp

IUSE=""

DESCRIPTION="Handle all sorts of compressed and encrypted files"
HOMEPAGE="http://freshmeat.net/projects/crypt++/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/emacs"

S="${WORKDIR}/${P}"

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
