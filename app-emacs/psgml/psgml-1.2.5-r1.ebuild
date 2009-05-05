# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/psgml/psgml-1.2.5-r1.ebuild,v 1.11 2009/05/05 08:03:37 fauli Exp $

inherit elisp

IUSE=""

DESCRIPTION="A GNU Emacs Major Mode for editing SGML and XML coded documents."
HOMEPAGE="http://sourceforge.net/projects/psgml/"
SRC_URI="mirror://sourceforge/psgml/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc amd64 ppc"

DEPEND="app-text/openjade"
RDEPEND="${DEPEND}"

SITEFILE=50psgml-gentoo.el

src_compile() {
	emacs --batch --no-site-file --no-init-file \
		--load psgml-maint.el -f psgml-compile-files || die "elisp compilaion failed"
}

src_install() {
	elisp-install ${PN} *.el *.elc *.map
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	dodoc ChangeLog INSTALL README.psgml psgml.ps
	doinfo psgml-api.info psgml.info
}
