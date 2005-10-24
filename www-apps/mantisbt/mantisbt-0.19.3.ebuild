# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/mantisbt/mantisbt-0.19.3.ebuild,v 1.2 2005/10/24 19:54:49 hansmi Exp $

inherit webapp eutils

S=${WORKDIR}/mantis-${PV}

IUSE=""

DESCRIPTION="PHP/MySQL/Web based bugtracking system"
HOMEPAGE="http://www.mantisbt.org/"
SRC_URI="mirror://sourceforge/${PN}/mantis-${PV}.tar.gz"

KEYWORDS="ppc ~x86"

RDEPEND="
	>=dev-db/mysql-3.23.32
	>=net-www/apache-1.3
	virtual/httpd-php
"

LICENSE="GPL-2"

src_unpack() {
	unpack ${A}
	find ${S} -name .cvsignore -exec rm {} \;
	epatch ${FILESDIR}/${PV}-debian.patch
}

src_install() {
	webapp_src_preinst
	dodoc doc/{CREDITS,CUSTOMIZATION,ChangeLog,LICENSE,README,UPGRADING}

	cp -R *.php admin core css graphs images lang ${D}/${MY_HTDOCSDIR}
	cp config_inc.php.sample ${D}/${MY_HTDOCSDIR}/config_inc.php

	webapp_configfile ${MY_HTDOCSDIR}/config_inc.php
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_sqlscript mysql ${S}/sql/db_generate.sql
	webapp_src_install
}
