# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/online-bookmarks/online-bookmarks-0.6.1c.ebuild,v 1.1 2005/10/25 21:30:12 rl03 Exp $

inherit webapp

S=${WORKDIR}/${PN}

DESCRIPTION="A Bookmark management system to store your Bookmarks, Favorites and Links right in the WWW where they actually belong"
HOMEPAGE="http://www.frech.ch/online-bookmarks/index.php"
SRC_URI="http://www.frech.ch/online-bookmarks/download/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

IUSE=""

RDEPEND="virtual/httpd-php
	dev-db/mysql"

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	webapp_src_preinst

	dodoc CHANGES README

	cp -R * "${D}/${MY_HTDOCSDIR}"

	webapp_configfile "${MY_HTDOCSDIR}/config/config.php"
	webapp_configfile "${MY_HTDOCSDIR}/config/connect.php"

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_src_install
}
