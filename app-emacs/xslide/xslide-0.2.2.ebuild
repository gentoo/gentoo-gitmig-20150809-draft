# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/xslide/xslide-0.2.2.ebuild,v 1.6 2005/08/28 02:32:26 tester Exp $

inherit elisp

IUSE=""

DESCRIPTION="xslide is an Emacs major mode for editing XSL stylesheets and running XSL processes."
HOMEPAGE="http://www.menteith.com/xslide/"
SRC_URI="mirror://sourceforge/xslide/${P}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ppc ~ppc-macos x86"

DEPEND="app-arch/unzip"
RDEPEND=""

SITEFILE=50xslide-gentoo.el

src_compile() {
	make EMACS=emacs || die
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
	dodoc CHANGELOG.TXT README.TXT
}
