# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/refbase/refbase-0.8.0.ebuild,v 1.4 2008/02/02 15:14:30 hollow Exp $

inherit depend.apache webapp

DESCRIPTION="Web-based solution for managing scientific literature, references and citations"
HOMEPAGE="http://www.refbase.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""
RDEPEND="app-admin/webapp-config
	>=virtual/php-4.1.0
	>=virtual/mysql-4.1
	app-text/bibutils"
DEPEND="${RDEPEND}"

need_apache

src_install () {
	webapp_src_preinst

	DOCS="AUTHORS BUGS ChangeLog COPYING INSTALL NEWS README TODO UPDATE"
	dodoc ${DOCS}
	# Don't install docs to webroot
	rm -f ${DOCS}

	cp -R * "${D}"${MY_HTDOCSDIR}

	webapp_configfile ${MY_HTDOCSDIR}/initialize
	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt

	webapp_src_install
}
