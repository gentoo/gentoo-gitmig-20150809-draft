# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rarpd/rarpd-1.1-r1.ebuild,v 1.2 2003/09/12 15:43:49 seemant Exp $

inherit eutils

DESCRIPTION="Reverse Address Resolution Protocol Daemon"
HOMEPAGE="ftp://ftp.dementia.org/pub/net-tools"
SRC_URI="ftp://ftp.dementia.org/pub/net-tools/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND=">=net-libs/libnet-1.0.2a-r3
	<net-libs/libnet-1.1
	>=net-libs/libpcap-0.7.1"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-libnet-1.0.patch
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	#make install DESTDIR=${D} || die # only installs rarpd to /
	dosbin rarpd
	doman rarpd.8
	dodoc AUTHORS COPYING README TODO VERSION INSTALL
}
