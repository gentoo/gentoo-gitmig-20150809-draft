# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/mantisbt/mantisbt-1.0.0_rc4.ebuild,v 1.1 2005/12/14 17:57:31 rl03 Exp $

inherit webapp

IUSE="mysql postgres"
MY_PV=${PV/_rc/rc}

DESCRIPTION="PHP/MySQL/Web based bugtracking system"
HOMEPAGE="http://www.mantisbt.org/"
SRC_URI="mirror://sourceforge/${PN}/mantis-${MY_PV}.tar.gz"

S=${WORKDIR}/mantis-${MY_PV}

KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND="
	mysql? ( >=dev-db/mysql-3.23.32 )
	postgres? ( >=dev-db/postgresql-7 )
	net-www/apache
	virtual/httpd-php
"

LICENSE="GPL-2"

src_install() {
	webapp_src_preinst
	dodoc doc/*

	cp -R . ${D}/${MY_HTDOCSDIR}
	rm -rf ${D}/${MY_HTDOCSDIR}/doc

	mv ${D}/${MY_HTDOCSDIR}/config_inc.php.sample ${D}/${MY_HTDOCSDIR}/config_inc.php

	webapp_configfile ${MY_HTDOCSDIR}/config_inc.php
	webapp_postinst_txt en ${FILESDIR}/postinstall-en-1.0.0.txt
	webapp_src_install
}
