# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/sitebar/sitebar-3.2.6.ebuild,v 1.2 2004/08/30 23:33:34 dholm Exp $

inherit webapp

DESCRIPTION="The Bookmark Server for Personal and Team Use"
HOMEPAGE="http://sitebar.sourceforge.net/"
KEYWORDS="~x86 ~ppc"

IUSE=""
MY_PN=${PN/sitebar/SiteBar}
S=${WORKDIR}/${MY_PN}-${PV}

SRC_URI="mirror://sourceforge/${PN}/${MY_PN}-${PV}.tar.bz2"

DEPEND="net-www/apache
		virtual/php
		>=dev-db/mysql-3.23"
LICENSE="GPL-2"

src_compile() {
	:;
}

src_install() {
	webapp_src_preinst
	cd ${S}
	rm -f readme.txt doc/licence.txt
	dodoc doc/*
	rm -rf doc
	cp -R . ${D}/${MY_HTDOCSDIR}

	webapp_serverowned ${MY_HTDOCSDIR}/inc
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}
