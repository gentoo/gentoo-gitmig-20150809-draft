# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-tftp/netkit-tftp-0.17.ebuild,v 1.10 2002/12/09 04:33:17 manson Exp $

DESCRIPTION="the tftp server included in netkit"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/netkit-tftp-0.17.tar.gz"
HOMEPAGE="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/"

KEYWORDS="x86 sparc  ppc"
LICENSE="BSD"
SLOT="0"

src_compile() {
	./configure --prefix=/usr --installroot=${D} || die
	emake || die
}

src_install() {
	dodir /usr/bin /usr/sbin /usr/share/man/man1 /usr/share//man/man8
	make install || die
}
