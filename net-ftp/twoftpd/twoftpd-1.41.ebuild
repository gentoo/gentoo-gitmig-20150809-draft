# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/twoftpd/twoftpd-1.41.ebuild,v 1.2 2011/01/29 23:18:46 bangert Exp $

EAPI="2"

inherit eutils toolchain-funcs multilib

DESCRIPTION="Simple secure efficient FTP server by Bruce Guenter"
HOMEPAGE="http://untroubled.org/twoftpd/"
SRC_URI="http://untroubled.org/twoftpd/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="breakrfc"

DEPEND=">=dev-libs/bglibs-1.106
	>=net-libs/cvm-0.96"
RDEPEND="sys-apps/ucspi-tcp
	virtual/daemontools
	${DEPEND}"

src_prepare() {
	use breakrfc && epatch "${FILESDIR}"/${PN}-1.21-disable-TELNET_IAC.patch
}

src_configure() {
	echo "/usr/sbin" > conf-bin
	echo "/usr/share/man" > conf-man
	echo "/usr/include/bglibs" > conf-bgincs
	echo "/usr/$(get_libdir)/bglibs" > conf-bglibs
	echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	echo "$(tc-getCC) ${LDFLAGS}" > conf-ld
}

src_install() {
	emake install install_prefix="${D}" || die "install failed"

	dodoc ANNOUNCEMENT ChangeLog NEWS README TODO VERSION
	dodoc twoftpd.run twoftpd-log.run
}
