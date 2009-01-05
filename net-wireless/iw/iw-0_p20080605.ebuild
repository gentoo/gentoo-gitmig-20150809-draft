# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/iw/iw-0_p20080605.ebuild,v 1.1 2009/01/05 05:03:08 rbu Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION="nl80211 userspace tool for use with aircrack-ng"
HOMEPAGE="http://www.aircrack-ng.org"
SRC_URI="http://dl.aircrack-ng.org/${PN}.tar.bz2 -> ${P}.tar.bz2"

IUSE=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-libs/libnl-1.1"
RDEPEND="${DEPEND}"

CC=$(tc-getCC)
LD=$(tc-getLD)

src_prepare() {
	epatch "${FILESDIR}"/${P}-ldflags.patch
}

src_install() {
	emake DESTDIR="${D}/usr" install
}
