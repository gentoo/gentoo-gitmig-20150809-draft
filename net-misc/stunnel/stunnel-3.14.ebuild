# Distributed under the terms of the GNU General Public License, v2 or later
# Reviewed by Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/stunnel/stunnel-3.14.ebuild,v 1.1 2001/05/13 17:54:55 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="TSL/SSL - Port Wrapper"
SRC_URI="http://www.stunnel.org/download/stunnel/src/${A}"
HOMEPAGE="http://www.stunnel.org/"

DEPEND="virtual/glibc
	>=dev-libs/openssl-0.9.6"

RDEPEND=">dev-libs/openssl-0.9.6"

src_unpack() {
	unpack ${A}
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
	try ./configure --prefix=/usr --infodir=/usr/share/info \
		--mandir=/usr/share/man
	try make
}

src_install() {
	into /usr
	dosbin stunnel
	dodoc FAQ README HISTORY COPYING BUGS PORTS TODO transproxy.txt
	doman stunnel.8
	dolib.so stunnel.so
}
