# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/memoir/memoir-20050516.ebuild,v 1.1 2005/05/23 18:15:07 brix Exp $

inherit latex-package

S=${WORKDIR}/${PN}
DESCRIPTION="Flexible document class"
SRC_URI="mirror://gentoo/${P}.tgz"
HOMEPAGE="http://www.ctan.org/tex-archive/macros/latex/contrib/memoir/"
LICENSE="LPPL-1.3"

IUSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"

src_install() {
	cd ${S}
	latex-package_src_install

	dodoc README
}
