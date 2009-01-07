# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/iw/iw-0.9.7.ebuild,v 1.1 2009/01/07 15:09:31 rbu Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION="nl80211-based configuration utility for wireless devices using the mac80211 kernel stack"
HOMEPAGE="http://wireless.kernel.org/en/users/Documentation/iw"
SRC_URI="http://wireless.kernel.org/download/${PN}/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/libnl
	dev-util/pkgconfig"
RDEPEND="dev-libs/libnl"

CC=$(tc-getCC)
LD=$(tc-getLD)

src_prepare() {
	epatch "${FILESDIR}"/${P}-ldflags.patch
	epatch "${FILESDIR}"/${P}-cflags.patch
}

src_install() {
	emake install DESTDIR="${D}" || die "Failed to install"
}
