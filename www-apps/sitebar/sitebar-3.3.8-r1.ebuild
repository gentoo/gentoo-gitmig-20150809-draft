# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/sitebar/sitebar-3.3.8-r1.ebuild,v 1.4 2007/01/02 22:53:41 rl03 Exp $

inherit webapp eutils

WEBAPP_MANUAL_SLOT="yes"
SLOT="3.3.8"

DESCRIPTION="The Bookmark Server for Personal and Team Use"
HOMEPAGE="http://sitebar.sourceforge.net/"
KEYWORDS="~amd64 ppc ~x86"

IUSE=""
MY_PN=${PN/sitebar/SiteBar}
S=${WORKDIR}/${MY_PN}-${PV}

SRC_URI="mirror://sourceforge/${PN}/${MY_PN}-${PV}.tar.bz2"

DEPEND="net-www/apache
		virtual/php"
LICENSE="GPL-2"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/debian.patch
}

src_install() {
	webapp_src_preinst
	dodoc readme.txt doc/history.txt doc/install.txt doc/troubleshooting.txt
	cp -R . ${D}/${MY_HTDOCSDIR}
	rm -rf ${D}/${MY_HTDOCSDIR}/doc ${D}/${MY_HTDOCSDIR}/readme.txt

	webapp_serverowned ${MY_HTDOCSDIR}/inc
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}
