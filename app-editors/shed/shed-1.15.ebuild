# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/shed/shed-1.15.ebuild,v 1.2 2012/08/18 03:43:33 ottxor Exp $

EAPI="4"

inherit eutils

DESCRIPTION="Simple Hex EDitor"
HOMEPAGE="http://shed.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

RDEPEND="sys-libs/ncurses"
DPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-interix.patch
}

src_compile() {
	emake AM_CFLAGS="${CFLAGS}"
}
