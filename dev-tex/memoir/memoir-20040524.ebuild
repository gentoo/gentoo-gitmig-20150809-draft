# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/memoir/memoir-20040524.ebuild,v 1.1 2004/11/07 08:44:14 usata Exp $

inherit latex-package

S=${WORKDIR}/${PN}
DESCRIPTION="Flexible document class"
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://www.ctan.org/tex-archive/macros/latex/contrib/memoir/"
LICENSE="LPPL-1.3"

IUSE=""
SLOT="0"
KEYWORDS="~x86"

src_install() {
	cd ${S}
	latex-package_src_install

	dodoc README
}
