# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/groupoffice/groupoffice-2.05.ebuild,v 1.1 2004/11/14 13:30:01 mholzer Exp $

inherit webapp

S=${WORKDIR}/${PN}-com-${PV}
DESCRIPTION="Group-Office is a powerful modular Intranet application framework. It runs *nix using PHP and has several database support."
HOMEPAGE="http://group-office.sourceforge.net/"
SRC_URI="mirror://sourceforge/group-office/${PN}-com-${PV}.tar.gz
	mirror://sourceforge/group-office/GO-theme-crystal-1.93.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha ~amd64 ~sparc"
IUSE=""
DEPEND="virtual/php
	dev-db/mysql"

src_install() {
	webapp_src_preinst

	mv ${WORKDIR}/crystal ${S}/themes
	cd ${S}
	dodoc CHANGELOG DEVELOPERS FAQ INSTALL RELEASE README.ldap TODO TRANSLATORS
	rm -f CHANGELOG FAQ INSTALL README.ldap TODO TRANSLATORS

	cp -r . ${D}${MY_HTDOCSDIR}
	webapp_serverowned ${MY_HTDOCSDIR}

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}
