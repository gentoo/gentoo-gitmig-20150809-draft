# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-bootpd/netkit-bootpd-0.17-r1.ebuild,v 1.6 2002/07/09 09:26:59 phoenix Exp $

MY_PN=${PN/pd/paramd}
S=${WORKDIR}/${MY_PN}-${PV}
DESCRIPTION="Netkit - bootp"
SRC_URI="http://ftp.debian.org/debian/pool/main/n/netkit-bootparamd/${MY_PN}_${PV}.orig.tar.gz"
HOMEPAGE="http://packages.debian.org/unstable/net/bootparamd.html"
KEYWORDS="x86"
SLOT="0"

DEPEND=">=sys-libs/glibc-2.1.3"

src_compile() {
	./configure || die
	make || die
}

src_install() {							   
	into /usr
	dosbin rpc.bootparamd/bootparamd
	dosym  bootparamd /usr/sbin/rpc.bootparamd
	doman  rpc.bootparamd/bootparamd.8
	dosym  bootparamd.8.gz /usr/man/man8/rpc.bootparamd.8.gz
	doman  rpc.bootparamd/bootparams.5
	dodoc  README ChangeLog
	newdoc rpc.bootparamd/README README.bootparamd
} 
