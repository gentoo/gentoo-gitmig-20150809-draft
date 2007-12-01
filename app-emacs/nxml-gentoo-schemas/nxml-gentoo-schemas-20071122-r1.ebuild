# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/nxml-gentoo-schemas/nxml-gentoo-schemas-20071122-r1.ebuild,v 1.3 2007/12/01 15:56:18 ulm Exp $

inherit elisp

DESCRIPTION="Extension for nxml-mode with Gentoo-specific schemas"
HOMEPAGE="http://farragut.flameeyes.is-a-geek.org/"
SRC_URI="http://flameeyes.is-a-geek.org/files/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=app-emacs/nxml-mode-20041004-r3"

SITEFILE=60${PN}-gentoo.el

src_compile() { :; }

src_install() {
	insinto ${SITEETC}/${PN}
	doins schemas.xml *.rnc || die
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
}
