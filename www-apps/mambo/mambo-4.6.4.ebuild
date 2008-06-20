# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/mambo/mambo-4.6.4.ebuild,v 1.1 2008/06/20 16:10:29 wrobel Exp $

inherit webapp depend.php depend.apache

MY_PN="${PN/m/M}"
DESCRIPTION="Mambo is a dynamic portal engine and content management system"
HOMEPAGE="http://www.mamboserver.com/"
SRC_URI="http://mambo-code.org/gf/download/frsrelease/369/706/${MY_PN}V${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
S=${WORKDIR}

IUSE=""

need_php
need_apache

pkg_setup () {
	webapp_pkg_setup
	if ! PHPCHECKNODIE="yes" require_php_with_use mysql zlib || \
		! PHPCHECKNODIE="yes" require_php_with_any_use apache2 cgi ; then
			die "Re-install ${PHP_PKG} with mysql zlib and at least one of apache2 or cgi USE flags."
	fi
}

src_install () {
	webapp_src_preinst
	local files="administrator/backups administrator/components components
	images images/banners images/stories mambots mambots/content mambots/search
	media language administrator/modules administrator/templates cache modules
	templates mambots/editors mambots/editors-xtd uploadfiles configuration.php
	installation/langconfig.php"

	dodoc CHANGELOG.php INSTALL.php

	touch configuration.php

	cp -R [^d]* "${D}/${MY_HTDOCSDIR}"

	for file in ${files}; do
		webapp_serverowned "${MY_HTDOCSDIR}/${file}"
	done

	webapp_configfile "${MY_HTDOCSDIR}/configuration.php"
	webapp_configfile "${MY_HTDOCSDIR}/installation/langconfig.php"

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt

	webapp_src_install
}
