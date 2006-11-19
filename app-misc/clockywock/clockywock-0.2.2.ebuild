# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/clockywock/clockywock-0.2.2.ebuild,v 1.2 2006/11/19 01:34:20 tcort Exp $

inherit eutils

DESCRIPTION="ncurses analog clock"
HOMEPAGE="http://www.soomka.com/"
SRC_URI="http://www.soomka.com/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

# probably not needed since ncurses is in 'system', but I like to be pedantic
DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}"/${P}-cxxflags.patch
	epatch "${FILESDIR}"/${P}-headers.patch
}

src_install() {
	dobin clockywock
	dodoc README
}
