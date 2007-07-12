# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ucspi-ssl/ucspi-ssl-0.70.ebuild,v 1.2 2007/07/12 05:10:21 mr_bones_ Exp $

inherit fixheadtails toolchain-funcs
#eutils

IUSE="perl"
DESCRIPTION="Command-line tools for building SSL client-server applications."
HOMEPAGE="http://www.superscript.com/ucspi-ssl/intro.html"
SRC_URI="http://www.superscript.com/ucspi-ssl/${P}.tar.gz"

#		http://www.suspectclass.com/~sgifford/ucspi-tls/files/ucspi-ssl-0.70-ucspitls-0.1.patch"
DEPEND="virtual/libc
	>=dev-libs/openssl-0.9.6g
	sys-apps/ucspi-tcp"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~amd64"
S="${WORKDIR}/host/superscript.com/net/${P}/src"

src_unpack() {
	unpack ${A}
#	cd "${WORKDIR}/host/superscript.com/net/"
#	epatch ${DISTDIR}/ucspi-ssl-0.70-ucspitls-0.1.patch
	ht_fix_all
	cd ${S}
	#fix paths to work with gentoo...
	sed -i -e 's:HOME/command:/usr/bin:' sslcat.sh sslconnect.sh https\@.sh
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

# selftest requires installation - expects files in /usr/bin
#
#src_test() {
#	cd ..
#	./package/rts || die 'self test failed'
#}

src_install() {
	dodoc CHANGES TODO  UCSPI-SSL
	cd ${WORKDIR}/host/superscript.com/net/${P}/command/
	for i in sslserver sslclient sslcat sslconnect https\@
	do
		dobin $i
	done
	use perl && dobin sslperl
}
