# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/junkbust/junkbust-0.9.ebuild,v 1.1 2007/02/09 08:51:07 opfer Exp $

inherit elisp

IUSE=""

DESCRIPTION="An Emacs add-on for maintaining a personal configuration of the Junkbuster filtering HTTP proxy"
HOMEPAGE="http://www.neilvandyke.org/junkbust-emacs/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}
	net-proxy/junkbuster"

SITEFILE=50junkbust-gentoo.el

src_compile() {
	emacs --batch -f batch-byte-compile --no-site-file --no-init-file *.el
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
}

pkg_postinst() {
	elisp-site-regen
	elog "Please see ${SITELISP}/${PN}/junkbust.el for the complete documentation."
}

pkg_postrm() {
	elisp-site-regen
}
