# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/phppgadmin/phppgadmin-2.4.1-r1.ebuild,v 1.11 2003/09/06 22:25:50 msterret Exp $

MY_PN=phpPgAdmin
MY_PV="`echo ${PV} | sed -e 's:\.:-:g'`"

S=${WORKDIR}/${MY_PN}
DESCRIPTION="Web-based administration for Postgres database in php"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}_${MY_PV}.tar.bz2"
HOMEPAGE="http://phppgadmin.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="x86 ppc"
SLOT="0"

DEPEND=">=net-www/apache-1.3.24-r1
	>=dev-db/postgresql-7.0.3-r3
	>=dev-php/mod_php-4.1.2-r5"

src_compile() { :; }

src_install() {
	insinto /home/httpd/htdocs/phppgadmin
	doins *.{php,html,js,sh,php-dist}

	insinto /home/httpd/htdocs/phppgadmin/images
	doins images/*.gif

	dodoc BUGS ChangeLog DEVELOPERS Documentation.html INSTALL \
		README TODO
}

pkg_postinst() {
	einfo
	einfo "Make sure you edit /home/httpd/htdocs/phppgadmin/config.inc.php"
	einfo
}
