# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ucspi-ssl/ucspi-ssl-0.70.ebuild,v 1.3 2008/01/25 22:57:30 bangert Exp $

inherit fixheadtails toolchain-funcs eutils

IUSE="perl tls"
DESCRIPTION="Command-line tools for building SSL client-server applications."
HOMEPAGE="http://www.superscript.com/ucspi-ssl/intro.html"
SRC_URI="http://www.superscript.com/ucspi-ssl/${P}.tar.gz
		http://www.suspectclass.com/~sgifford/ucspi-tls/files/ucspi-ssl-0.70-ucspitls-0.1.patch"
DEPEND="virtual/libc
	>=dev-libs/openssl-0.9.6g
	sys-apps/ucspi-tcp"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~amd64"
MY_WD="${WORKDIR}/host/superscript.com/net"
S="${MY_WD}/${P}/src"

src_unpack() {
	unpack ${A}
	cd "${MY_WD}"
	use tls && epatch "${DISTDIR}"/ucspi-ssl-0.70-ucspitls-0.1.patch
	ht_fix_all
	cd "${S}"
	epatch "${FILESDIR}"/ucspi-ssl-0.70-fix-paths.patch
}

src_compile() {
	echo "$(tc-getCC) ${CFLAGS} -DTLS -I." > conf-cc
	echo "/usr/bin" > conf-tcpbin
	echo "/usr/" > conf-home
	echo "/usr/share/ca-certificates/" > conf-cadir
	echo "/var/qmail/control/dh1024.pem" > conf-dhfile
	cd ..
	package/compile || die
}

src_install() {
	dodoc CHANGES TODO UCSPI-SSL
	cd "${MY_WD}"/${P}/command/
	dobin sslserver sslclient sslcat sslconnect https\@ || die
	use perl && dobin sslperl
}
