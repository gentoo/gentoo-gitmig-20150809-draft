# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-talk/netkit-talk-0.17-r4.ebuild,v 1.1 2003/06/17 19:02:18 gmsoft Exp $

IUSE="ipv6"
MY_P=netkit-ntalk-${PV}
S=${WORKDIR}/netkit-ntalk-${PV}
DESCRIPTION="Netkit - talkd"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${MY_P}.tar.gz"
HOMEPAGE="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips"
LICENSE="BSD"
SLOT="0"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2"

src_unpack() {
    unpack ${A}
    patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
	cd ${S}
	use ipv6 && patch -p1 < ${FILESDIR}/${P}-ipv6.diff
}

src_compile() {
    try ./configure
    cp MCONFIG MCONFIG.orig
    sed -e "s:-O2 -Wall:-Wall:" -e "s:-Wpointer-arith::" MCONFIG.orig > MCONFIG
    try make
}

src_install() {                               
	insinto /etc/xinetd.d
	newins ${FILESDIR}/talk.xinetd talk 
	into /usr
	dobin  talk/talk
	doman  talk/talk.1
	dosbin talkd/talkd
	dosym  talkd /usr/sbin/in.talkd
	doman  talkd/talkd.8
	dosym  talkd.8.gz /usr/share/man/man8/in.talkd.8.gz
	dodoc  README ChangeLog BUGS
}


