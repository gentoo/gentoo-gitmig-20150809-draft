# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/phppgadmin/phppgadmin-3.5.3.ebuild,v 1.3 2005/07/06 19:17:46 rl03 Exp $

inherit eutils webapp

IUSE=""

# This package insists on uppercase letters
MY_PN=phpPgAdmin
MY_P=${MY_PN}-${PV}
S="${WORKDIR}/${MY_PN}"

DESCRIPTION="Web-based administration for Postgres database in php"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
HOMEPAGE="http://phppgadmin.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~hppa ~amd64"

DEPEND=">=dev-db/postgresql-7.0.0
	virtual/httpd-php"

RDEPEND="${DEPEND}
	!<=dev-db/phppgadmin-3.3.1"

src_install() {
	webapp_src_preinst

	local docs="DEVELOPERS FAQ HISTORY INSTALL TODO TRANSLATORS CREDITS BUGS"
	dodoc ${docs}
	mv conf/config.inc.php-dist conf/config.inc.php

	cp -r * ${D}${MY_HTDOCSDIR}
	for doc in ${docs} INSTALL LICENSE; do
		rm -f ${D}${MY_HTDOCSDIR}/${doc}
	done

	webapp_configfile ${MY_HTDOCSDIR}/conf/config.inc.php
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_src_install
}
