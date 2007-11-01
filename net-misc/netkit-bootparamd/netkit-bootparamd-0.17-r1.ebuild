# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-bootparamd/netkit-bootparamd-0.17-r1.ebuild,v 1.1 2007/11/01 21:28:58 jokey Exp $

DESCRIPTION="Netkit - bootparamd"
HOMEPAGE="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/"
SRC_URI="mirror://debian/pool/main/n/netkit-bootparamd/${PN}_${PV}.orig.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~hppa mips ppc sparc x86"
IUSE=""

src_compile() {
	# this is needed here
	./configure || die "configure failed"
	make || die "make failed"
}

src_install() {
	into /usr
	dosbin rpc.bootparamd/bootparamd || die "binary install failed"
	dosym bootparamd /usr/sbin/rpc.bootparamd
	doman rpc.bootparamd/bootparamd.8
	dosym bootparamd.8 /usr/share/man/man8/rpc.bootparamd.8
	doman rpc.bootparamd/bootparams.5
	dodoc README ChangeLog
	newdoc rpc.bootparamd/README README.bootparamd
}
