# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-rwho/netkit-rwho-0.17.ebuild,v 1.1 2003/05/22 21:06:17 mholzer Exp $

MY_P=netkit-rwho-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Netkit - ruptime/rwho/rwhod"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${MY_P}.tar.gz"
HOMEPAGE="http://www.hcs.harvard.edu/~dholland/computers/netkit.html"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips"
LICENSE="BSD"
SLOT="0"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
	./configure || die
	sed -i "s:-O2::" -i "s:-Wpointer-arith::" MCONFIG
	emake || die
}

src_install() {
	keepdir /var/spool/rwho

	into /usr
	dobin ruptime/ruptime
	doman ruptime/ruptime.1
	dobin rwho/rwho
	doman rwho/rwho.1
	dosbin rwhod/rwhod
	doman rwhod/rwhod.8
	dodoc README ChangeLog

	exeinto /etc/init.d
	newexe ${FILESDIR}/${PF}-rc rwhod
}
