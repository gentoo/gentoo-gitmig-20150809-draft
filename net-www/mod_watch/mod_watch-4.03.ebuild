# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_watch/mod_watch-4.03.ebuild,v 1.3 2004/09/03 23:24:08 pvdabeel Exp $

DESCRIPTION="Bandwidth graphing for Apache with MRTG"
HOMEPAGE="http://www.snert.com/Software/mod_watch/"
KEYWORDS="~x86 ppc"

MY_V="`echo ${PV} | sed -e 's:\.::g'`"
S=${WORKDIR}/${P}
SRC_URI="http://www.snert.com/Software/download/${PN}${MY_V}.tgz"

DEPEND="=net-www/apache-2*
	>=sys-apps/sed-4"
LICENSE="as-is"
SLOT="0"
S="${WORKDIR}/${PN}-4.3"

src_compile() {
	sed -i \
		-e "s:APXS=/home/apache2/bin/apxs:APXS=/usr/sbin/apxs2:" \
		-e "s:APACHECTL=apachectl:APACHECTL=/usr/sbin/apache2ctl:" \
		Makefile.dso || die "Path fixing failed."
	make -f Makefile.dso build || die "Make failed."
}

src_install() {
	exeinto /usr/lib/apache2-extramodules
	doexe .libs/mod_watch.so

	exeinto /usr/sbin
	doexe apache2mrtg.pl
	doexe mod_watch.pl

	dodir /var/lib/mod_watch
	dohtml index.shtml

	insinto /etc/apache2/conf/addon-modules
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
