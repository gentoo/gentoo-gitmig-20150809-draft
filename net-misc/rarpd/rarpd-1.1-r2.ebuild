# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rarpd/rarpd-1.1-r2.ebuild,v 1.4 2004/07/15 03:22:15 agriffis Exp $

inherit eutils

DESCRIPTION="Reverse Address Resolution Protocol Daemon"
HOMEPAGE="ftp://ftp.dementia.org/pub/net-tools"
SRC_URI="ftp://ftp.dementia.org/pub/net-tools/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND=">=net-libs/libnet-1.0.2a-r3
	<net-libs/libnet-1.1
	>=net-libs/libpcap-0.7.1"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-libnet-1.0.patch
	epatch ${FILESDIR}/${PV}-daemon.patch
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
	insinto /etc/conf.d
	newins ${FILESDIR}/rarpd.conf.d rarpd
	exeinto /etc/init.d
	newexe ${FILESDIR}/rarpd.init.d rarpd
}
