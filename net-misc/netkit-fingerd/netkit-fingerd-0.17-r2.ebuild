# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-fingerd/netkit-fingerd-0.17-r2.ebuild,v 1.7 2002/08/16 22:20:40 gerk Exp $

MY_PN=${PN/netkit/bsd}
MY_PN=${MY_PN/rd/r}
S=${WORKDIR}/${MY_PN}-${PV}
DESCRIPTION="Netkit - fingerd"
SRC_URI="http://ftp.debian.org/debian/pool/main/b/${MY_PN}/${MY_PN}_${PV}.orig.tar.gz"
HOMEPAGE="http://packages.debian.org/unstable/net/fingerd.html"
DEPEND=">=sys-libs/glibc-2.1.3"
KEYWORDS="x86 ppc sparc sparc64"
LICENSE="bsd"
SLOT="0"

src_unpack() {
	unpack ${A}
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {	 
	./configure || die
	make || die
}

src_install() {							   
	into /usr
	dobin  finger/finger
	dosbin fingerd/fingerd
	dosym  fingerd /usr/sbin/in.fingerd
	doman  finger/finger.1
	doman  fingerd/fingerd.8
	dosym  fingerd.8.gz /usr/man/man8/in.fingerd.8.gz
	dodoc  README ChangeLog BUGS
}
