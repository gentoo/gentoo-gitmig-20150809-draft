# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/jaffm/jaffm-1.3.ebuild,v 1.1 2006/05/21 10:12:19 blubb Exp $

DESCRIPTION="Very lightweight file manager"
HOMEPAGE="http://jaffm.binary.is/"

SRC_URI="http://www.binary.is/download/${P}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND=">=x11-libs/wxGTK-2.6"

src_install() {
	dobin jaffm
	dodoc README
}
