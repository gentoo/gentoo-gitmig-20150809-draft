# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/stunnel/stunnel-3.22-r1.ebuild,v 1.4 2002/08/14 12:08:08 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="TSL/SSL - Port Wrapper"
SRC_URI="http://www.stunnel.org/download/stunnel/src/${P}.tar.gz"
HOMEPAGE="http://www.stunnel.org/"
DEPEND="virtual/glibc >=dev-libs/openssl-0.9.6c"
RDEPEND=">=dev-libs/openssl-0.9.6c"
KEYWORDS="x86 sparc sparc64"
LICENSE="GPL-2"
SLOT="0"

src_unpack() {
	unpack ${A}; cd ${S}
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
	./configure --prefix=/usr --infodir=/usr/share/info --mandir=/usr/share/man || die
	emake || die
}

src_install() {
	into /usr
	dosbin stunnel
	dodoc FAQ README HISTORY COPYING BUGS PORTS TODO transproxy.txt
	doman stunnel.8
	dolib.so stunnel.so
}
