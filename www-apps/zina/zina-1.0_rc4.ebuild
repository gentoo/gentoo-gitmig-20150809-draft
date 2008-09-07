# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/zina/zina-1.0_rc4.ebuild,v 1.1 2008/09/07 17:35:16 wrobel Exp $

inherit webapp depend.php

MY_P=${P/_/}

DESCRIPTION="Zina (Zina Is Not Andromeda) is a digital audio streaming jukebox via a web interface."
HOMEPAGE="http://www.pancake.org/zina/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

need_httpd_cgi
need_php_httpd

S="${WORKDIR}"/${MY_P}

src_install() {
	webapp_src_preinst

	touch zina.ini.php

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	webapp_configfile "${MY_HTDOCSDIR}"/zina.ini.php
	webapp_serverowned "${MY_HTDOCSDIR}"/zina.ini.php

	keepdir "${MY_HTDOCSDIR}"/_zina/cache
	webapp_serverowned "${MY_HTDOCSDIR}"/_zina/cache

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	webapp_src_install
}
