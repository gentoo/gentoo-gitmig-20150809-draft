# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-talk/netkit-talk-0.17-r4.ebuild,v 1.11 2004/09/05 17:12:14 aliz Exp $

inherit eutils

IUSE="ipv6"

MY_P=netkit-ntalk-${PV}
S=${WORKDIR}/netkit-ntalk-${PV}

DESCRIPTION="Netkit - talkd"
HOMEPAGE="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc sparc alpha mips ~amd64"

DEPEND="virtual/libc
	>=sys-libs/ncurses-5.2"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PF}-gentoo.diff
	cd ${S}
	use ipv6 && patch -p1 < ${FILESDIR}/${P}-ipv6.diff
}

src_compile() {
	./configure || die
	cp MCONFIG MCONFIG.orig
	sed -e "s:-O2 -Wall:-Wall:" -e "s:-Wpointer-arith::" MCONFIG.orig > MCONFIG
	make || die
}

src_install() {
	insinto /etc/xinetd.d
	newins ${FILESDIR}/talk.xinetd talk
	into /usr
	dobin talk/talk
	doman talk/talk.1
	dosbin talkd/talkd
	dosym talkd /usr/sbin/in.talkd
	doman talkd/talkd.8
	dosym talkd.8.gz /usr/share/man/man8/in.talkd.8.gz
	dodoc README ChangeLog BUGS
}
