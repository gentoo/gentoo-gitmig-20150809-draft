# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-rwall/netkit-rwall-0.17.ebuild,v 1.3 2007/01/26 08:48:29 vapier Exp $

DESCRIPTION="Netkit - rwall"
HOMEPAGE="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""

src_compile() {
	./configure || die
	sed -i -e "s:-O2 -Wall:-Wall:" -e "s:-Wpointer-arith::" MCONFIG
	emake || die
}

src_install() {
	dobin rwall/rwall || die
	doman rwall/rwall.1
	dosbin rpc.rwalld/rwalld || die
	doman rpc.rwalld/rpc.rwalld.8
	dosym rpc.rwalld.8 /usr/share/man/man8/rwall.8
	dodoc README ChangeLog BUGS
}
