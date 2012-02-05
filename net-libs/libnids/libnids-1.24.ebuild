# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnids/libnids-1.24.ebuild,v 1.9 2012/02/05 18:36:58 armin76 Exp $

EAPI=2
inherit eutils

DESCRIPTION="emulates the IP stack of Linux 2.0.x and offers IP defragmentation, TCP stream assembly and TCP port scan detection."
HOMEPAGE="http://libnids.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="1.2"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="net-libs/libpcap
	dev-libs/glib
	>=net-libs/libnet-1.1.0-r3"
RDEPEND="${DEPEND}
	!net-libs/libnids:1.1"

src_prepare() {
	epatch "${FILESDIR}/${P}-ldflags.patch"
}

src_configure() {
	econf --enable-shared || die "econf failed"
}

src_install() {
	emake install_prefix="${D}" install || die "emake install failed"
	dodoc CHANGES CREDITS MISC README
	dodoc doc/*
}
