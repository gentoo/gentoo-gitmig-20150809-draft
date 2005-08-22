# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/phpgroupware/phpgroupware-0.9.16.006.ebuild,v 1.4 2005/08/22 21:02:52 rl03 Exp $

inherit webapp

S=${WORKDIR}/${PN}

DESCRIPTION="intranet/groupware tool and application framework"
HOMEPAGE="http://www.phpgroupware.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
IUSE=""
LICENSE="GPL-2"
KEYWORDS="~alpha amd64 ~hppa ppc ~sparc ~x86"

RDEPEND="virtual/httpd-php"

src_unpack() {
	unpack ${A}
	cd ${S}
	# remove CVS directories
	find . -type d -name 'CVS' -print | xargs rm -rf
}

src_install() {
	webapp_src_preinst

	cp -R . ${D}/${MY_HTDOCSDIR}
	dohtml ${PN}/doc/en_US/html/admin/*.html

	webapp_serverowned ${MY_HTDOCSDIR}/fudforum
#	webapp_serverowned ${MY_HTDOCSDIR}/phpgwapi/images

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_src_install
}
