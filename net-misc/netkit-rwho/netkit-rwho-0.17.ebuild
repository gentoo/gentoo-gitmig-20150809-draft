# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-rwho/netkit-rwho-0.17.ebuild,v 1.2 2003/06/08 05:26:26 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Netkit - ruptime/rwho/rwhod"
HOMEPAGE="http://www.hcs.harvard.edu/~dholland/computers/netkit.html"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips"

DEPEND="virtual/glibc
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PF}-gentoo.diff
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
