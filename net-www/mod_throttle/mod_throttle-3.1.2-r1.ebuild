# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_throttle/mod_throttle-3.1.2-r1.ebuild,v 1.9 2004/04/05 01:17:06 zul Exp $

DESCRIPTION="Bandwidth and request throttling for Apache"
HOMEPAGE="http://www.snert.com/Software/mod_throttle/"
KEYWORDS="x86 sparc"

MY_V="`echo ${PV} | sed -e 's:\.::g'`"
S=${WORKDIR}/${P}
SRC_URI="http://www.snert.com/Software/${PN}/${PN}${MY_V}.tgz"

DEPEND="=net-www/apache-1*"
LICENSE="as-is"
SLOT="0"

src_compile() {
	make || die "compile problem"
}

src_install() {
	exeinto /usr/lib/apache-extramodules
	doexe mod_throttle.so

	dodoc CHANGES.txt LICENSE.txt
	dohtml index.shtml

	insinto /etc/apache/conf/addon-modules
	doins ${FILESDIR}/mod_throttle.conf
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
		extramodules/mod_throttle.so mod_throttle.c throttle_module \
		define=THROTTLE addconf=conf/addon-modules/mod_throttle.conf
	:;
}
