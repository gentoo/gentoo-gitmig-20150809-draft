# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/mantisbt/mantisbt-0.18.3.ebuild,v 1.2 2004/08/30 19:26:47 rl03 Exp $

inherit webapp

IUSE=""

DESCRIPTION="PHP/MySQL/Web based bugtracking system"
HOMEPAGE="http://www.mantisbt.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

KEYWORDS="~x86"

RDEPEND="
	>=dev-db/mysql-3.23.32
	>=net-www/apache-1.3
	>=dev-php/mod_php-4.0.6
"

LICENSE="GPL-2"

src_unpack() {
	unpack ${A}
	find ${S} -name .cvsignore -exec rm {} \;
}

src_install() {
	webapp_src_preinst
	dohtml doc/*.{html,css}
	dodoc doc/{CREDITS,CUSTOMIZATION,ChangeLog,LICENSE,README,TROUBLESHOOTING,UPGRADING}

	cp -R *.php admin core css graphs images lang ${D}/${MY_HTDOCSDIR}
	cp config_inc.php.sample ${D}/${MY_HTDOCSDIR}/config_inc.php

	webapp_configfile ${MY_HTDOCSDIR}/config_inc.php
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_sqlscript mysql ${S}/sql/db_generate.sql
	webapp_src_install
}
