# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/nxml-gentoo-schemas/nxml-gentoo-schemas-20111129.ebuild,v 1.1 2011/11/29 21:08:05 flameeyes Exp $

NEED_EMACS=23
inherit elisp

DESCRIPTION="Extension for nxml-mode with Gentoo-specific schemas"
HOMEPAGE="http://dev.gentoo.org/~flameeyes/${PN}/"
SRC_URI="http://dev.gentoo.org/~flameeyes/${PN}/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

SITEFILE=60${PN}-gentoo.el

src_compile() { :; }

src_install() {
	insinto ${SITEETC}/${PN}
	doins schemas.xml *.rnc || die "install failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	dodoc DONATING
}
