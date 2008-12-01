# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/crda/crda-0.9.4.ebuild,v 1.2 2008/12/01 14:06:51 chainsaw Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Central Regulatory Domain Agent for wireless networks."
HOMEPAGE="http://wireless.kernel.org/en/developers/Regulatory"
SRC_URI="http://wireless.kernel.org/download/crda/${P}.tar.bz2"
LICENSE="as-is"
SLOT="0"

KEYWORDS="~amd64"
IUSE=""
DEPEND="dev-libs/libgcrypt
	dev-libs/libnl
	dev-python/m2crypto
	net-wireless/wireless-regdb"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-as-needed.patch"
}

src_compile() {
	emake -j1 CC="$(tc-getCC)" || die "Compilation failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
