# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/junkbust/junkbust-0.8.ebuild,v 1.5 2004/06/15 08:40:05 kloeri Exp $

inherit elisp

IUSE=""

DESCRIPTION="An Emacs add-on for maintaining a personal configuration of the Junkbuster filtering HTTP proxy"
HOMEPAGE="http://www.neilvandyke.org/junkbust-emacs/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/emacs"
RDEPEND="${DEPEND}
	net-www/junkbuster"

SITEFILE=50junkbust-gentoo.el

src_compile() {
	emacs --batch -f batch-byte-compile --no-site-file --no-init-file *.el
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}

pkg_postinst() {
	elisp-site-regen
	einfo "Please see ${SITELISP}/${PN}/junkbust.el for the complete documentation."
}

pkg_postrm() {
	elisp-site-regen
}
