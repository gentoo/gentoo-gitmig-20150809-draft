# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-rwall/netkit-rwall-0.17.ebuild,v 1.1 2004/10/23 17:27:58 wmertens Exp $

#S=${WORKDIR}/netkit-rwall-${PV}
#S=${WORKDIR}/${P}
DESCRIPTION="Netkit - rwall"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${P}.tar.gz"
HOMEPAGE="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/"
KEYWORDS="x86 ppc sparc"
SLOT="0"
LICENSE="BSD"
IUSE=""

DEPEND="virtual/libc"
RDEPEND="virtual/libc"

src_compile() {
	./configure || die
	sed -i~ -e "s:-O2 -Wall:-Wall:" -e "s:-Wpointer-arith::" MCONFIG
	make || die
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
