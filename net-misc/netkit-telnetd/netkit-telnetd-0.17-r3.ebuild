# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-telnetd/netkit-telnetd-0.17-r3.ebuild,v 1.23 2004/04/10 06:13:04 vapier Exp $

inherit eutils

DESCRIPTION="Standard Linux telnet client and server"
HOMEPAGE="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/netkit-telnet-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa mips amd64 ppc64"
IUSE="build"

DEPEND=">=sys-libs/ncurses-5.2"

S=${WORKDIR}/netkit-telnet-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/netkit-telnetd-0.17-gentoo.patch
}

src_compile() {
	./configure --prefix=/usr || die

	sed -i \
		-e "s:-pipe -O2:${CFLAGS}:" \
		-e "s:-Wpointer-arith::" \
		MCONFIG

	make || die
	cd telnetlogin
	make || die
}

src_install() {
	into /usr
	dobin telnet/telnet || die
	#that's it if we're going on a build image
	use build && return 0

	dosbin telnetd/telnetd || die
	dosym telnetd /usr/sbin/in.telnetd
	dosbin telnetlogin/telnetlogin || die
	doman telnet/telnet.1
	doman telnetd/*.8
	doman telnetd/issue.net.5
	dosym telnetd.8.gz /usr/share/man/man8/in.telnetd.8.gz
	doman telnetlogin/telnetlogin.8
	dodoc BUGS ChangeLog README
	dodoc ${FILESDIR}/net.issue.sample
	newdoc telnet/README README.telnet
	newdoc telnet/TODO TODO.telnet
	insinto /etc/xinetd.d
	newins ${FILESDIR}/telnetd.xinetd telnetd
}
