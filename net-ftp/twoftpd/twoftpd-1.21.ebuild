# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/twoftpd/twoftpd-1.21.ebuild,v 1.1 2006/05/14 15:49:00 bangert Exp $

inherit toolchain-funcs

DESCRIPTION="Simple secure efficient FTP server by Bruce Guenter"
HOMEPAGE="http://untroubled.org/twoftpd/"
SRC_URI="http://untroubled.org/twoftpd/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc
		>=dev-libs/bglibs-1.026
		>=net-libs/cvm-0.32"
RDEPEND="sys-apps/ucspi-tcp
		sys-process/daemontools
		>=net-libs/cvm-0.32"

src_compile() {
	echo "${D}/usr/sbin" > conf-bin
	echo "${D}/usr/share/man" > conf-man
	echo "$(tc-getCC) ${CFLAGS} -I${ROOT}/usr/include/bglibs" > conf-cc
	echo "$(tc-getCC) -s -L${ROOT}/usr/lib/bglibs" > conf-ld
	make || die "make failed"
}

src_install() {
	dodir /usr/sbin
	dodir /usr/share/man/man1

	make install || die "install failed"

	dodoc ANNOUNCEMENT COPYING ChangeLog NEWS README TODO VERSION
	dodoc twoftpd.run twoftpd-log.run
}

