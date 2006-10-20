# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/mambo/mambo-4.6.1.ebuild,v 1.1 2006/10/20 14:43:22 rl03 Exp $

inherit webapp depend.php

MY_PN="${PN/m/M}"
DESCRIPTION="Mambo is a dynamic portal engine and content management system"
HOMEPAGE="http://www.mamboserver.com/"
SRC_URI="http://mamboxchange.com/frs/download.php/8291/${MY_PN}V${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
S=${WORKDIR}

IUSE="mysql"

RDEPEND="mysql? ( dev-db/mysql )
	virtual/httpd-php
	net-www/apache"

pkg_setup () {
	webapp_pkg_setup
	require_php_with_use mysql zlib
}

src_install () {
	webapp_src_preinst
	local files="administrator/backups administrator/components components
	images images/banners images/stories mambots mambots/content mambots/search
	media language administrator/modules administrator/templates cache modules
	templates mambots/editors mambots/editors-xtd uploadfiles"

	dodoc CHANGELOG.php INSTALL.php README

	cp -R [^d]* ${D}/${MY_HTDOCSDIR}

	for file in ${files}; do
		webapp_serverowned "${MY_HTDOCSDIR}/${file}"
	done

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}
