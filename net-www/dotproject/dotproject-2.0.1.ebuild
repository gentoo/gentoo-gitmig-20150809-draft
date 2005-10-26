# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/dotproject/dotproject-2.0.1.ebuild,v 1.2 2005/10/26 13:49:23 rl03 Exp $

inherit webapp

MY_P="${PN}_${PV}"
DESCRIPTION="dotProject is a PHP web-based project management framework"
HOMEPAGE="http://www.dotproject.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
RDEPEND="net-www/apache
	virtual/httpd-php
	>=dev-db/mysql-3.23"

S=${WORKDIR}/${PN}
LICENSE="GPL-2"

src_install () {
	webapp_src_preinst

	dodoc ChangeLog README

	mv includes/config-dist.php includes/config.php
	cp -R * ${D}${MY_HTDOCSDIR}

	webapp_configfile ${MY_HTDOCSDIR}/includes/config.php
	webapp_serverowned ${MY_HTDOCSDIR}/files
	webapp_serverowned ${MY_HTDOCSDIR}/files/temp
	webapp_serverowned ${MY_HTDOCSDIR}/locales/en

	webapp_postinst_txt en ${FILESDIR}/install-en.txt
	webapp_src_install
}
