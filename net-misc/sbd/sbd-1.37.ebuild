# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sbd/sbd-1.37.ebuild,v 1.1 2005/08/25 23:38:30 swegener Exp $

inherit toolchain-funcs

DESCRIPTION="Netcat-clone, designed to be portable and offer strong encryption"
HOMEPAGE="http://tigerteam.se/dl/sbd/"
SRC_URI="http://tigerteam.se/dl/sbd/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=""

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		UNIX_CFLAGS="" \
		UNIX_LDFLAGS="" \
		unix || die "emake failed"
}

src_install() {
	dobin sbd || die "dobin failed"
	dodoc CHANGES README || die "dodoc failed"
}
