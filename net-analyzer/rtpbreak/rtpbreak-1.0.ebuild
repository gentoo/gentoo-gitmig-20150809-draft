# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/rtpbreak/rtpbreak-1.0.ebuild,v 1.1 2007/05/28 15:19:29 drizzt Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Detects, reconstructs and analyzes any RTP session through heuristics over the UDP network traffic."
HOMEPAGE="http://xenion.antifork.org/rtpbreak/rtpbreak.html"
SRC_URI="http://xenion.antifork.org/rtpbreak/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=net-libs/libnet-1.1
	>=net-libs/libpcap-0.7"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-ldflags.patch
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin rtpbreak || die "cannot install rtpbreak"
	dodoc README.{en,it}
}
