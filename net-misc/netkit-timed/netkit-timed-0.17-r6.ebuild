# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-timed/netkit-timed-0.17-r6.ebuild,v 1.14 2003/12/17 04:32:18 brad_mssw Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Netkit - timed"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${P}.tar.gz"
HOMEPAGE="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/"
KEYWORDS="x86 sparc ppc mips ppc64"
LICENSE="BSD"
SLOT="0"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cp ${FILESDIR}/timed.c ${S}/timed/timed/timed.c
}

src_compile() {
	./configure || die
	make || die
}

src_install() {
	dosbin timed/timed/timed
	doman  timed/timed/timed.8
	dosbin timed/timedc/timedc
	doman  timed/timedc/timedc.8
	dodoc  README ChangeLog BUGS

	exeinto /etc/init.d
	newexe ${FILESDIR}/timed.rc6 timed
}
