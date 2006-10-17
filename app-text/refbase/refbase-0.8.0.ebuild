# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/refbase/refbase-0.8.0.ebuild,v 1.1 2006/10/17 20:50:08 dberkholz Exp $

inherit webapp

DESCRIPTION="Web-based solution for managing scientific literature, references and citations"
HOMEPAGE="http://www.refbase.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""
RDEPEND="net-www/apache
	app-admin/webapp-config
	>=virtual/php-4.1.0
	>=dev-db/mysql-4.1
	app-text/bibutils"
DEPEND="${RDEPEND}"

src_install () {
	webapp_src_preinst

	DOCS="AUTHORS BUGS ChangeLog COPYING INSTALL NEWS README TODO UPDATE"
	dodoc ${DOCS}
	# Don't install docs to webroot
	rm -f ${DOCS}

	cp -R * "${D}"${MY_HTDOCSDIR}

	webapp_configfile ${MY_HTDOCSDIR}/initialize
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}
