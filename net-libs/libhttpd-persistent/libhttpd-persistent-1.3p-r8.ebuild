# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libhttpd-persistent/libhttpd-persistent-1.3p-r8.ebuild,v 1.3 2004/10/19 07:40:28 eradicator Exp $

IUSE=""

inherit toolchain-funcs

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
	LOFILES=${CFILES//.c/.lo}
	OFILES=${CFILES//.c/.o}

	for FILE in ${CFILES}; do
		echo $(tc-getCXX) ${CFLAGS} -D_OS_UNIX -c ${FILE} -o ${FILE//.c/.o}
		$(tc-getCXX) ${CFLAGS} -D_OS_UNIX -c ${FILE} -o ${FILE//.c/.o} || die
		echo $(tc-getCXX) ${CFLAGS} -D_OS_UNIX -fPIC -c ${FILE} -o ${FILE//.c/.lo}
		$(tc-getCXX) ${CFLAGS} -D_OS_UNIX -fPIC -c ${FILE} -o ${FILE//.c/.lo} || die
	done

#	echo $(tc-getAR) rc libhttpd-persistent.a ${OFILES} || die
#	$(tc-getAR) rc libhttpd-persistent.a ${OFILES} || die
#	echo $(tc-getRANLIB) libhttpd-persistent.a || die
#	$(tc-getRANLIB) libhttpd-persistent.a || die
	echo ar rc libhttpd-persistent.a ${OFILES} || die
	ar rc libhttpd-persistent.a ${OFILES} || die
	echo ranlib libhttpd-persistent.a || die
	ranlib libhttpd-persistent.a || die

	echo $(tc-getCXX) -shared -Wl,-shared,-soname,libhttpd-persistent.so \
		${LOFILES} -o libhttpd-persistent.so || die
	$(tc-getCXX) -shared -Wl,-shared,-soname,libhttpd-persistent.so \
		${LOFILES} -o libhttpd-persistent.so || die
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
