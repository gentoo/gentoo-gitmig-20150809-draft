# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ucarp/ucarp-1.1.ebuild,v 1.1 2004/09/19 20:40:23 tantive Exp $

inherit eutils

DESCRIPTION="UCARP allows a couple of hosts to share common virtual IP addresses in order to provide automatic failover. It is a portable userland implementation of the secure and patent-free Common Address Redundancy Protocol (CARP, OpenBSD's alternative to the VRRP).
Strong points of the CARP protocol are : very low overhead, cryptographically signed messages, interoperability between different operating systems and no need for any dedicated extra network link between redundant hosts.
"
HOMEPAGE="http://www.ucarp.org"
LICENSE="GPL-2"
DEPEND=">=net-libs/libpcap-0.8.3-r1"
SRC_URI="ftp://ftp.ucarp.org/pub/ucarp/${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

src_compile() {
	cd "${S}"
	econf || die

	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install-strip || die
	#einstall || die

	dodoc README INSTALL NEWS ChangeLog || die
	dodoc examples/linux/vip-up.sh examples/linux/vip-down.sh
}
