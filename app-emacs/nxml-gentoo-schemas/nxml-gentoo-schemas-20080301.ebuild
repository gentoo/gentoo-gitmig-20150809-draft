# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/nxml-gentoo-schemas/nxml-gentoo-schemas-20080301.ebuild,v 1.1 2008/03/01 00:22:35 flameeyes Exp $

inherit elisp

DESCRIPTION="Extension for nxml-mode with Gentoo-specific schemas"
HOMEPAGE="http://blog.flameeyes.eu/"
SRC_URI="http://www.flameeyes.eu/files/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=app-emacs/nxml-mode-20041004-r3"

SITEFILE=60${PN}-gentoo.el

src_compile() { :; }

src_install() {
	insinto ${SITEETC}/${PN}
	doins schemas.xml *.rnc || die "install failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	dodoc DONATING
}
