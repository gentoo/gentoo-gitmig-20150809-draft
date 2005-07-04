# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/mantisbt/mantisbt-1.0.0_alpha3.ebuild,v 1.1 2005/07/04 00:26:53 rl03 Exp $

inherit webapp

IUSE=""
MY_PV=${PV/_alpha/a}

DESCRIPTION="PHP/MySQL/Web based bugtracking system"
HOMEPAGE="http://www.mantisbt.org/"
SRC_URI="mirror://sourceforge/${PN}/mantis-${MY_PV}.tar.gz"

S=${WORKDIR}/mantis-${MY_PV}

KEYWORDS="~x86 ~ppc"

RDEPEND="
	>=dev-db/mysql-3.23.32
	net-www/apache
	>=virtual/php-4.0.6
"

LICENSE="GPL-2"

src_install() {
	webapp_src_preinst
	dodoc doc/*

	cp -R . ${D}/${MY_HTDOCSDIR}
	rm -rf ${D}/${MY_HTDOCSDIR}/doc

	mv ${D}/${MY_HTDOCSDIR}/config_inc.php.sample ${D}/${MY_HTDOCSDIR}/config_inc.php

	webapp_configfile ${MY_HTDOCSDIR}/config_inc.php
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_sqlscript mysql ${S}/sql/db_generate.sql
	webapp_src_install
}
