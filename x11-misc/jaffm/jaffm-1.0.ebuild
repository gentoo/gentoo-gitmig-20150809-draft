# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/jaffm/jaffm-1.0.ebuild,v 1.5 2005/02/11 18:31:02 port001 Exp $

DESCRIPTION="Just A F*****g File Manager"
HOMEPAGE="http://jaffm.binary.is/"

SRC_URI="http://www.binary.is/download/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=x11-libs/wxGTK-2.4"

src_compile() {
	emake || die
}

src_install() {
	dobin jaffm
	dodoc COPYING README
}
