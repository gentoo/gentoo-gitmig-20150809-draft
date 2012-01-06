# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/psgml/psgml-1.3.2.ebuild,v 1.5 2012/01/06 16:42:33 ranger Exp $

inherit elisp

DESCRIPTION="A GNU Emacs Major Mode for editing SGML and XML coded documents"
HOMEPAGE="http://sourceforge.net/projects/psgml/"
SRC_URI="mirror://sourceforge/psgml/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE=""

DEPEND="app-text/openjade"
RDEPEND="${DEPEND}"

SITEFILE="50${PN}-gentoo.el"

src_compile() {
	emacs --batch --no-site-file --no-init-file \
		--load psgml-maint.el -f psgml-compile-files || die
}

src_install() {
	elisp-install ${PN} *.el *.elc *.map || die
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	dodoc ChangeLog INSTALL README.psgml psgml.ps || die
	doinfo psgml-api.info psgml.info || die
}
