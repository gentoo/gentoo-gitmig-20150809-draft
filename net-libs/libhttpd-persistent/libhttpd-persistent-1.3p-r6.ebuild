# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libhttpd-persistent/libhttpd-persistent-1.3p-r6.ebuild,v 1.1 2004/03/31 01:57:46 eradicator Exp $

MY_P="libhttpd-1.3p-f"

DESCRIPTION="libhttpd-persistent is a modified version of David Hughes' libhttpd."
HOMEPAGE="http://www.deleet.de/projekte/daap/daapd/"
SRC_URI="http://www.deleet.de/projekte/daap/daapd/${MY_P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""

S="${WORKDIR}/libhttpd-1.3-persistent-f"

src_compile() {
	econf || die

	# This is for versions since libhttpd-1.3p-e until the configure
	# process properly detects g++
	sed -i 's:gcc:g++:' Site.mm
	# end gcc to g++ edits.

	emake || die

	cd ${S}/src
	ranlib libhttpd-persistent.a
	echo g++ ${CFLAGS} -D_OS_UNIX -fPIC protocol.c api.c version.c ip_acl.c select.c -o libhttpd-persistent.so -Wl,-shared,-soname,libhttpd-persistent.so
	g++ ${CFLAGS} -D_OS_UNIX -fPIC protocol.c api.c version.c ip_acl.c select.c -o libhttpd-persistent.so -Wl,-shared,-soname,libhttpd-persistent.so
}

src_install() {
	# This pacakge doesn't respect anything autoconf-ish
	dolib.a src/libhttpd-persistent.a
	dolib.so src/libhttpd-persistent.so

	mkdir -p ${D}/usr/include/
	cp src/httpd-persistent.h ${D}/usr/include/
	chmod 644 ${D}/usr/include/httpd-persistent.h

	dodoc HISTORY License README doc/FAQ.txt doc/libhttpd.pdf
}
