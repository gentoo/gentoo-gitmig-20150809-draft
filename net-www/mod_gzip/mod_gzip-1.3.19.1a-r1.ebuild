# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_gzip/mod_gzip-1.3.19.1a-r1.ebuild,v 1.9 2004/04/04 22:48:29 zul Exp $

DESCRIPTION="Apache module which acts as an Internet Content Accelerator"
HOMEPAGE="http://www.remotecommunications.com/apache/mod_gzip/"
KEYWORDS="x86 sparc"

S=${WORKDIR}/${P}
SRC_URI="http://www.remotecommunications.com/apache/${PN}/src/${PV}/${PN}.c.gz"

DEPEND="virtual/glibc =net-www/apache-1* >=sys-libs/zlib-1.1.4"
LICENSE="Apache-1.1"
SLOT="0"

src_unpack() {
	mkdir ${P} ; cd ${S}
	cp ${DISTDIR}/${A} .
	gunzip ${A} || die
}

src_compile() {
	/usr/sbin/apxs -I/usr/include -L/usr/lib -lz -c mod_gzip.c
	assert "compile problem"
}

src_install() {
	exeinto /usr/lib/apache-extramodules
	doexe mod_gzip.so

	dodoc ${FILESDIR}/{changes,commands}.txt

	insinto /etc/apache/conf/addon-modules
	doins ${FILESDIR}/mod_gzip.conf
}

pkg_postinst() {
	einfo
	einfo "Execute \"ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config\""
	einfo "to have your apache.conf auto-updated for use with this module."
	einfo "You should then edit your /etc/conf.d/apache file to suit."
	einfo
}

pkg_config() {
	${ROOT}/usr/sbin/apacheaddmod \
		${ROOT}/etc/apache/conf/apache.conf \
		extramodules/mod_gzip.so mod_gzip.c gzip_module \
		define=GZIP addconf=conf/addon-modules/mod_gzip.conf
	:;
}
