# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/phprojekt/phprojekt-5.2.ebuild,v 1.1 2007/01/03 19:03:17 rl03 Exp $

inherit webapp depend.php

DESCRIPTION="Project management and coordination system"
HOMEPAGE="http://www.phprojekt.com/"
#SRC_URI="http://phprojekt.com/releases/${PN}/${P}.tar.gz"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"
IUSE="postgres mysql"

#DEPEND="app-arch/unzip"

need_php

pkg_setup () {
	webapp_pkg_setup
	local php_flags="imap"
	use mysql && php_flags="${php_flags} mysql"
	use postgres && php_flags="${php_flags} postgres"
	require_php_with_use ${php_flags}
}

src_install() {
	webapp_src_preinst
	dodoc readme install
	local file

	cp -R . ${D}/${MY_HTDOCSDIR}
	for file in attach chat; do
		webapp_serverowned ${MY_HTDOCSDIR}/${file}
	done
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}
