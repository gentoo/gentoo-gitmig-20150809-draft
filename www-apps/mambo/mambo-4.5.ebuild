# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/mambo/mambo-4.5.ebuild,v 1.2 2004/08/30 19:25:34 rl03 Exp $

inherit webapp

DESCRIPTION="Mambo is yet another CMS"
SRC_URI="http://mamboforge.net/frs/download.php/1145/MamboV4.5-Stable-1.0.9.tar.gz"
HOMEPAGE="http://www.mamboserver.com/"

LICENSE="GPL-2"
KEYWORDS="~x86"
S=${WORKDIR}

IUSE=""

RDEPEND="dev-db/mysql
	virtual/php
	net-www/apache"

pkg_setup () {
	webapp_pkg_setup
	einfo "Please make sure that your PHP is compiled with zlib, XML, and MySQL support"
}

src_install () {
	webapp_src_preinst
	local files="administrator/backups administrator/components components images media language modules templates uploadfiles"

	cd ${S}

	dodoc documentation/Changelog-4.5
	rm -rf documentation

	cp -R . ${D}/${MY_HTDOCSDIR}

	for file in ${files}; do
		webapp_serverowned "${MY_HTDOCSDIR}/${file}"
	done

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_hook_script ${FILESDIR}/reconfig

	webapp_src_install
}
