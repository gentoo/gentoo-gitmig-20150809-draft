# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/dragonflycms/dragonflycms-9.2.1.ebuild,v 1.2 2009/07/07 23:31:43 flameeyes Exp $

inherit webapp depend.php

MY_P=Dragonfly${PV}

DESCRIPTION="A feature-rich open source content management system based off of PHP-Nuke 6.5"
HOMEPAGE="http://dragonflycms.org"
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"

RESTRICT="fetch"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~x86"
IUSE=""

need_httpd_cgi
need_php_httpd

S="${WORKDIR}"

pkg_nofetch() {
	elog "Please download ${MY_P}.tar.bz2 from:"
	elog "http://dragonflycms.org/Downloads/get=28.html"
	elog "and move it to ${DISTDIR}"
}

src_install() {
	webapp_src_preinst

	dodoc documentation/{BACKUP,IMPORTANT_NOTES,INSTALL,README,UPGRADE}.txt

	insinto "${MY_HTDOCSDIR}"
	doins -r public_html/*

	webapp_configfile "${MY_HTDOCSDIR}"/install/config.php

	for x in cpg_error.log includes cache modules/coppermine/albums \
			modules/coppermine/albums/userpics uploads/avatars \
			uploads/forums; do
		webapp_serverowned "${MY_HTDOCSDIR}"/${x}
	done

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	webapp_src_install
}
