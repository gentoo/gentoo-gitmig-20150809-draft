# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-rwall/netkit-rwall-0.17-r1.ebuild,v 1.1 2010/09/20 02:26:19 jer Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="Netkit - rwall"
HOMEPAGE="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_prepare() {
	sed -i -e "s:-O2 -Wall:-Wall:" -e "s:-Wpointer-arith::" MCONFIG
	sed -i configure -e '/^LDFLAGS=/d' || die "sed configure"
}

src_configure() {
	./configure --with-c-compiler=$(tc-getCC) || die
}

src_install() {
	dobin rwall/rwall || die
	doman rwall/rwall.1
	dosbin rpc.rwalld/rwalld || die
	doman rpc.rwalld/rpc.rwalld.8
	dosym rpc.rwalld.8 /usr/share/man/man8/rwall.8
	dodoc README ChangeLog BUGS
}
