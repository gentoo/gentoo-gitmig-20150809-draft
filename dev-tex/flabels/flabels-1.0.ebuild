# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/flabels/flabels-1.0.ebuild,v 1.1 2004/11/07 14:09:13 usata Exp $

inherit latex-package

DESCRIPTION="Macros for typesetting pretty lables (optionally colored) for the back of files or binders."
HOMEPAGE="http://www.ctan.org/tex-archive/help/Catalogue/entries/flabels.html"
# downloaded from:
# ftp.ctan.org/tex-archive/help/Catalogue/entries/flabels.tar.gz
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="LPPL-1.2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

S=${WORKDIR}/${PN}
DOCS="README"

src_compile() {
	latex-package_src_compile
	chmod +x makedoc
	./makedoc
}
