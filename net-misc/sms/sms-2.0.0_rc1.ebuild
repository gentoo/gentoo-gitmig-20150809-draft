# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sms/sms-2.0.0_rc1.ebuild,v 1.2 2004/10/14 19:54:03 dholm Exp $

DESCRIPTION="Command line program for sending SMS to Polish GSM mobile phone users"
HOMEPAGE="http://ceti.pl/~miki/komputery/sms.html"
SRC_URI="http://ceti.pl/~miki/komputery/download/sms/${P/_/-}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
RDEPEND="virtual/libc
	sys-libs/gdbm
	dev-libs/libpcre
	dev-libs/pcre++
	net-misc/curl"

DEPEND="${RDEPEND}
	sys-devel/gcc
	sys-apps/sed"

S=${WORKDIR}/${PN}

src_compile() {
	emake CXXFLAGS="${CXXFLAGS} -I./lib" || die
}

src_install() {
	dobin sms2
}
