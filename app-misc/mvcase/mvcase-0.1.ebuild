# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/mvcase/mvcase-0.1.ebuild,v 1.2 2004/06/24 22:26:09 agriffis Exp $

DESCRIPTION="A modified version of mv, used to convert filenames to lower/upper case"
SRC_URI="http://www.ibiblio.org/pub/Linux/utils/file/${P}.tar.gz"
HOMEPAGE="http://www.ibiblio.org/pub/Linux/utils/file"
LICENSE="GPL-2"
DEPEND="dev-libs/shhopt"
IUSE=""
SLOT="0"
KEYWORDS="~ppc"

src_compile() {
	emake || die
}

src_install () {
	dobin mvcase
	doman mvcase.1
	dodoc COPYING INSTALL
}
