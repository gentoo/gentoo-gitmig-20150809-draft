# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/mantisbt/mantisbt-1.0.6.ebuild,v 1.3 2007/01/02 22:37:55 rl03 Exp $

inherit webapp

IUSE=""
MY_P=mantis-${PV}

DESCRIPTION="PHP/MySQL/Web based bugtracking system"
HOMEPAGE="http://www.mantisbt.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

S=${WORKDIR}/${MY_P}

KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND="
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
