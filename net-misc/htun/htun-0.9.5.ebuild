# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/htun/htun-0.9.5.ebuild,v 1.7 2007/07/12 02:52:15 mr_bones_ Exp $

DESCRIPTION="Project to tunnel IP traffic over HTTP"
HOMEPAGE="http://htun.runslinux.net/"
SRC_URI="http://htun.runslinux.net/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND="virtual/libc
	dev-util/yacc"
RDEPEND=""

src_compile() {

	cd ${S}/src
	make all || die
}

src_install() {
	dosbin ${S}/src/htund

	insinto /etc
	doins ${S}/doc/htund.conf
	dodoc doc/*

	einfo
	einfo "NOTE: HTun requires the Universal TUN/TAP module"
	einfo "available in the Linux kernel.  Make sure you have"
	einfo "compiled the tun.o driver as a module!"
	einfo
	einfo "It can be found in the kernel configuration under"
	einfo "Network Device Support --> Universal TUN/TAP"
	einfo
	einfo "To configure HTun, run the following commands as root:"
	einfo "  # mknod /dev/net/tun c 10 200"
	einfo "  # echo \"alias char-major-10-200 tun\" >> /etc/modules.conf"
	einfo "  # depmod -e"
	einfo
}
