# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libhttpd-persistent/libhttpd-persistent-1.3p-r8.ebuild,v 1.2 2004/09/22 17:50:23 eradicator Exp $

IUSE=""

MY_P="libhttpd-1.3p-h"
S="${WORKDIR}/libhttpd-1.3-persistent-h"

DESCRIPTION="libhttpd-persistent is a modified version of David Hughes' libhttpd."
HOMEPAGE="http://www.deleet.de/projekte/daap/daapd/"
SRC_URI="http://www.deleet.de/projekte/daap/daapd/${MY_P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc amd64 sparc"
DEPEND=""

src_compile() {
	econf || die

	# Package provided compilation is FUBAR
	cd ${S}/src

	CFILES="protocol.c api.c version.c ip_acl.c select.c"
	OFILES=${CFILES//.c/.o}

	for FILE in ${CFILES}; do
		echo g++ ${CFLAGS} -D_OS_UNIX -fPIC -c ${FILE}
		g++ ${CFLAGS} -D_OS_UNIX -fPIC -c ${FILE} || die
	done

	echo "linking"
	ar rc libhttpd-persistent.a ${OFILES} || die
	ranlib libhttpd-persistent.a || die

	g++ -shared -Wl,-shared,-soname,libhttpd-persistent.so \
		${OFILES} -o libhttpd-persistent.so || die
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
