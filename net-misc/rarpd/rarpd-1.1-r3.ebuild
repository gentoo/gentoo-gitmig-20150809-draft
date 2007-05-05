# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rarpd/rarpd-1.1-r3.ebuild,v 1.1 2007/05/05 05:49:40 vapier Exp $

inherit eutils

DESCRIPTION="Reverse Address Resolution Protocol Daemon"
HOMEPAGE="ftp://ftp.dementia.org/pub/net-tools"
SRC_URI="ftp://ftp.dementia.org/pub/net-tools/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=net-libs/libnet-1.1
	net-libs/libpcap"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-daemon.patch
	epatch "${FILESDIR}"/${P}-libnet.diff
	epatch "${FILESDIR}"/${P}-fix-packet-growth-bug246891.diff #176558
	epatch "${FILESDIR}"/${P}-printf.diff
}

src_install() {
	dosbin rarpd || die
	doman rarpd.8
	dodoc AUTHORS README TODO VERSION INSTALL
	newconfd "${FILESDIR}"/rarpd.conf.d rarpd
	newinitd "${FILESDIR}"/rarpd.init.d rarpd
}
