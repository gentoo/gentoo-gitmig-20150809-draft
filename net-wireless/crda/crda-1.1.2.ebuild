# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/crda/crda-1.1.2.ebuild,v 1.1 2011/08/28 13:46:31 flameeyes Exp $

inherit toolchain-funcs multilib

DESCRIPTION="Central Regulatory Domain Agent for wireless networks."
HOMEPAGE="http://wireless.kernel.org/en/developers/Regulatory"
SRC_URI="http://wireless.kernel.org/download/crda/${P}.tar.bz2"
LICENSE="as-is"
SLOT="0"

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""
RDEPEND="dev-libs/libgcrypt
	dev-libs/libnl
	net-wireless/wireless-regdb"
DEPEND="${RDEPEND}
	dev-python/m2crypto"

src_compile() {
	emake CC="$(tc-getCC)" all_noverify || die "Compilation failed"
}

src_test() {
	emake CC="$(tc-getCC)" verify || die "emake verify failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
