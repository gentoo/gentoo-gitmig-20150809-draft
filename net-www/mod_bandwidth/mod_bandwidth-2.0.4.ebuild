# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_bandwidth/mod_bandwidth-2.0.4.ebuild,v 1.2 2004/04/04 22:36:52 zul Exp $

DESCRIPTION="Bandwidth Management Module for Apache"
HOMEPAGE="http://www.cohprog.com/v3/bandwidth/intro-en.html"
SRC_URI="ftp://ftp.cohprog.com/pub/apache/module/1.3.0/mod_bandwidth.c"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="=net-www/apache-1*"

src_unpack() {
	mkdir -p ${S} && cp ${DISTDIR}/${A} ${S} || die
	cd ${S} || die
	patch <${FILESDIR}/mod_bandwidth-2.0.4-register.patch || die
}

src_compile() {
	apxs -c ${S}/mod_bandwidth.c -o ${S}/mod_bandwidth.so
}

src_install() {
	exeinto /usr/lib/apache-extramodules
	doexe ${PN}.so

	insinto /etc/apache/conf/addon-modules
	doins ${FILESDIR}/${PN}.conf

	dodoc ${PN}.c
}

pkg_postinst() {
	# empty dirs..
	install -m0755 -o apache -g apache -d \
		${ROOT}/var/cache/mod_bandwidth/{link,master}

	einfo
	einfo "Execute \"ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config\""
	einfo "to have your apache.conf auto-updated for use with this module."
	einfo "You should then edit your /etc/conf.d/apache file to suit."
	einfo
	einfo "For configuration documentation, look at"
	einfo "http://www.cohprog.com/v3/bandwidth/doc-en.html"
	einfo
	einfo "Be sure to add -D BANDWIDTH to your /etc/conf.d/apache in order for"
	einfo "the module to be actually loaded."
	einfo
}

pkg_config() {
	${ROOT}/usr/sbin/apacheaddmod \
		${ROOT}/etc/apache/conf/apache.conf \
		extramodules/mod_bandwidth.so mod_bandwidth.c bandwidth_module \
		define=BANDWIDTH addconf=conf/addon-modules/mod_bandwidth.conf
	:;
}
