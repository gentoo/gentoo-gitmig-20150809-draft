# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-rwall/netkit-rwall-0.17.ebuild,v 1.2 2004/10/24 09:53:19 wmertens Exp $

DESCRIPTION="Netkit - rwall"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${P}.tar.gz"
HOMEPAGE="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/"
KEYWORDS="~x86"
SLOT="0"
LICENSE="BSD"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	./configure || die
	mv MCONFIG MCONFIG.ori
	sed -e "s:-O2 -Wall:-Wall:" -e "s:-Wpointer-arith::" MCONFIG.ori > MCONFIG
	emake || die
}

src_install() {
	into /usr
	dobin  rwall/rwall
	doman  rwall/rwall.1
	dosbin rpc.rwalld/rwalld
	doman  rpc.rwalld/rpc.rwalld.8
	dosym  rpc.rwalld.8.gz /usr/share/man/man8/rwall.8.gz
	dodoc  README ChangeLog BUGS
}
