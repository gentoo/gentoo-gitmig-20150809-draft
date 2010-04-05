# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnids/libnids-1.24.ebuild,v 1.3 2010/04/05 20:11:09 hwoarang Exp $

EAPI=2
inherit eutils

DESCRIPTION="emulates the IP stack of Linux 2.0.x and offers IP defragmentation, TCP stream assembly and TCP port scan detection."
HOMEPAGE="http://libnids.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="1.2"
KEYWORDS="~alpha amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="net-libs/libpcap
	>=net-libs/libnet-1.1.0-r3"
RDEPEND="${DEPEND}
	!net-libs/libnids:1.1"

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.20-chksum.c-ebx.patch"
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
