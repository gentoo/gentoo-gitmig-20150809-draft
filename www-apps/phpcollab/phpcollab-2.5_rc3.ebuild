# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/phpcollab/phpcollab-2.5_rc3.ebuild,v 1.1 2005/08/22 21:06:25 rl03 Exp $

inherit webapp

MY_P=${P/_rc/-rc}
S=${WORKDIR}/${PN}-2.5

IUSE=""

DESCRIPTION="phpCollab is an open-source internet-enabled collaboration workspace for project teams"
HOMEPAGE="http://php-collab.com/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

KEYWORDS="~x86 ~ppc"

RDEPEND="
	>=net-www/apache-1.3
	|| ( >=dev-db/mysql-3.23 >=dev-db/postgresql-7 )
	virtual/httpd-php
"

LICENSE="GPL-2"

src_install() {
	webapp_src_preinst
	dodoc docs/* docs/modules/*
	mv includes/settings_blank.php includes/settings.php

	cp -R . ${D}/${MY_HTDOCSDIR}
	rm -rf ${D}/${MY_HTDOCSDIR}/docs/[d-z]* ${D}/${MY_HTDOCSDIR}/docs/changes.txt

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_serverowned ${MY_HTDOCSDIR}/files
	webapp_serverowned ${MY_HTDOCSDIR}/logos_clients
	webapp_serverowned ${MY_HTDOCSDIR}/includes/settings.php
	webapp_src_install
}
