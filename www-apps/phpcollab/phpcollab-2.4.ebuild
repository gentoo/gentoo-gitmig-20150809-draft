# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/phpcollab/phpcollab-2.4.ebuild,v 1.8 2007/01/02 22:45:58 rl03 Exp $

inherit webapp

S=${WORKDIR}/PRODUCT24/${PN}

IUSE=""

DESCRIPTION="phpCollab is an open-source internet-enabled collaboration workspace for project teams"
HOMEPAGE="http://php-collab.com/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

KEYWORDS="~x86 ppc"

RDEPEND="
	>=net-www/apache-1.3
	virtual/httpd-php
"

LICENSE="GPL-2"

src_install() {
	webapp_src_preinst
	dodoc docs/* docs/modules/*
	mv includes/settings_blank.php includes/settings.php

	cp -R . ${D}/${MY_HTDOCSDIR}
	rm -rf ${D}/${MY_HTDOCSDIR}/docs/[d-z]*  ${D}/${MY_HTDOCSDIR}/install.txt \
		${D}/${MY_HTDOCSDIR}/docs/changes.txt

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_serverowned ${MY_HTDOCSDIR}/files
	webapp_serverowned ${MY_HTDOCSDIR}/logos_clients
	webapp_serverowned ${MY_HTDOCSDIR}/includes/settings.php
	webapp_src_install
}
