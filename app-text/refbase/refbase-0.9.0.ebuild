# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/refbase/refbase-0.9.0.ebuild,v 1.1 2008/02/12 19:22:36 markusle Exp $

inherit depend.apache depend.php webapp

DESCRIPTION="Web-based solution for managing scientific literature, references and citations"
HOMEPAGE="http://www.refbase.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="app-admin/webapp-config
	app-text/bibutils"

need_apache
need_php

pkg_setup() {
	require_php_with_use mysql pcre session
	webapp_pkg_setup
}

src_install () {
	webapp_src_preinst

	DOCS="AUTHORS BUGS ChangeLog NEWS README TODO UPDATE"
	dodoc ${DOCS}
	# Don't install docs to webroot
	rm -f ${DOCS} COPYING INSTALL

	cp -R * "${D}"${MY_HTDOCSDIR}

	webapp_configfile ${MY_HTDOCSDIR}/initialize
	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt

	webapp_src_install
}
