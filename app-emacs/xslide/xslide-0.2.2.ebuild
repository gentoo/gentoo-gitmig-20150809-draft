# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/xslide/xslide-0.2.2.ebuild,v 1.4 2004/11/03 04:49:01 usata Exp $

inherit elisp

IUSE=""

DESCRIPTION="xslide is an Emacs major mode for editing XSL stylesheets and running XSL processes."
HOMEPAGE="http://www.menteith.com/xslide/"
SRC_URI="mirror://sourceforge/xslide/${P}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~alpha ~ppc-macos"

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
