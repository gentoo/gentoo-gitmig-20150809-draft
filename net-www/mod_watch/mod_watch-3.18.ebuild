# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_watch/mod_watch-3.18.ebuild,v 1.5 2004/11/04 08:16:46 urilith Exp $

DESCRIPTION="Bandwidth graphing for Apache with MRTG"
HOMEPAGE="http://www.snert.com/Software/mod_watch/"
KEYWORDS="~x86"

MY_V="`echo ${PV} | sed -e 's:\.::g'`"
S=${WORKDIR}/${P}
SRC_URI="http://www.snert.com/Software/download/${PN}${MY_V}.tgz"

IUSE=""
DEPEND="=net-www/apache-1*"
LICENSE="as-is"
SLOT="0"

src_compile() {
	make build-dynamic || die "compile problem"
}

src_install() {
	exeinto /usr/lib/apache-extramodules
	doexe mod_watch.so

	exeinto /usr/sbin
	doexe apache2mrtg.pl
	doexe mod_watch.pl

	dodoc CHANGES.txt LICENSE.txt
	dohtml index.shtml

	insinto /etc/apache/conf/addon-modules
	doins ${FILESDIR}/mod_watch.conf
}

pkg_postinst() {
	einfo
	einfo "Execute \"ebuild /usr/portage/net-www/${PF}/${PF}.ebuild config\""
	einfo "to have your apache.conf auto-updated for use with this module."
	einfo "You should then edit your /etc/conf.d/apache file to suit."
	einfo
}

pkg_config() {
	${ROOT}/usr/sbin/apacheaddmod \
		${ROOT}/etc/apache/conf/apache.conf \
		extramodules/mod_watch.so mod_watch.c watch_module \
		define=WATCH addconf=conf/addon-modules/mod_watch.conf
	:;
}
