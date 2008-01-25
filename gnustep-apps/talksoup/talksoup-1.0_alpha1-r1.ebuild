# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/talksoup/talksoup-1.0_alpha1-r1.ebuild,v 1.3 2008/01/25 17:59:41 opfer Exp $

inherit gnustep-2

MY_P="TalkSoup-1.0alpha"
S=${WORKDIR}/${MY_P}

DESCRIPTION="IRC client for GNUstep"
HOMEPAGE="http://talksoup.aeruder.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

KEYWORDS="~amd64 ~ppc x86"
SLOT="0"
LICENSE="GPL-1"

DEPEND=">=gnustep-libs/netclasses-1.05"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-make2_support.patch"
}
