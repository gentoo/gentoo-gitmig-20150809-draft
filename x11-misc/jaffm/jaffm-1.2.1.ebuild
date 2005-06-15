# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/jaffm/jaffm-1.2.1.ebuild,v 1.2 2005/06/15 07:59:43 dholm Exp $

DESCRIPTION="Very lightweight file manager"
HOMEPAGE="http://jaffm.binary.is/"

SRC_URI="http://www.binary.is/download/${P}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="virtual/x11
	>=x11-libs/wxGTK-2.6"

src_compile() {
	emake || die
}

src_install() {
	dobin jaffm
	dodoc COPYING README
}
