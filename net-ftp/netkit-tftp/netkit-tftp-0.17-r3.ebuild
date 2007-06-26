# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/netkit-tftp/netkit-tftp-0.17-r3.ebuild,v 1.2 2007/06/26 02:25:17 mr_bones_ Exp $

inherit eutils

DESCRIPTION="the tftp server included in netkit"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/netkit-tftp-0.17.tar.gz"
HOMEPAGE="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/"

KEYWORDS="x86 sparc ppc mips amd64 ppc64"
IUSE=""
LICENSE="BSD"
SLOT="0"

DEPEND="!virtual/tftp"
PROVIDE="virtual/tftp"

src_compile() {
	# Change default man directory
	epatch ${FILESDIR}/man.patch
	# Solve QA warning by including string.h
	epatch ${FILESDIR}/memset.patch

	./configure --prefix=/usr --installroot=${D} || die
	emake || die
}

src_install() {
	dodir /usr/bin /usr/sbin
	doman tftp/tftp.1 tftpd/tftpd.8
	make install || die
}
