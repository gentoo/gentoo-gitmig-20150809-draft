# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-telnetd/netkit-telnetd-0.17-r3.ebuild,v 1.7 2002/08/16 09:42:32 seemant Exp $

P2=netkit-telnet-${PV}
S=${WORKDIR}/${P2}
DESCRIPTION="Standard Linux telnet client"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${P2}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND=">=sys-libs/ncurses-5.2"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/netkit-telnetd-0.17-gentoo.patch || die
}

src_compile() {                           
	econf || die

	cp MCONFIG MCONFIG.orig
	sed -e "s/-pipe -O2/${CFLAGS}/" -e "s:-Wpointer-arith::" \
		MCONFIG.orig > MCONFIG

	make || die
	cd telnetlogin
	make || die
}

src_install() {
	into /usr
	dobin telnet/telnet
	#that's it if we're going on a build image
	use build && return
	
	dosbin telnetd/telnetd
	dosym telnetd /usr/sbin/in.telnetd
	dosbin telnetlogin/telnetlogin
	doman telnet/telnet.1
	doman telnetd/*.8
	doman telnetd/issue.net.5

	dosym telnetd.8.gz /usr/share/man/man8/in.telnetd.8.gz
	doman telnetlogin/telnetlogin.8
	dodoc BUGS ChangeLog README
	dodoc ${FILESDIR}/net.issue.sample
	newdoc telnet/README README.telnet
	newdoc telnet/TODO TODO.telnet
}
