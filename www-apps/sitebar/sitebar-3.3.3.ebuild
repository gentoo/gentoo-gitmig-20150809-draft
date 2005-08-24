# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/sitebar/sitebar-3.3.3.ebuild,v 1.3 2005/08/24 02:46:54 hparker Exp $

inherit webapp

DESCRIPTION="The Bookmark Server for Personal and Team Use"
HOMEPAGE="http://sitebar.sourceforge.net/"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""
MY_PN=${PN/sitebar/SiteBar}
S=${WORKDIR}/${MY_PN}-${PV}

SRC_URI="mirror://sourceforge/${PN}/${MY_PN}-${PV}.tar.bz2"

DEPEND="net-www/apache
		virtual/php
		>=dev-db/mysql-3.23"
LICENSE="GPL-2"

src_install() {
	webapp_src_preinst
	dodoc readme.txt doc/history.txt doc/install.txt doc/troubleshooting.txt
	cp -R . ${D}/${MY_HTDOCSDIR}
	rm -rf ${D}/${MY_HTDOCSDIR}/doc ${D}/${MY_HTDOCSDIR}/readme.txt

	webapp_serverowned ${MY_HTDOCSDIR}/inc
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}
