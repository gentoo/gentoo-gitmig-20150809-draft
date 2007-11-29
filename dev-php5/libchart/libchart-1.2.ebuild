# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/libchart/libchart-1.2.ebuild,v 1.1 2007/11/29 23:45:15 jokey Exp $

inherit php-lib-r1 depend.php

DESCRIPTION="Libchart is a chart creation PHP library that is easy to use."
HOMEPAGE="http://naku.dohcrew.com/libchart"
SRC_URI="http://naku.dohcrew.com/${PN}/files/${P}.tar.gz"

LICENSE="GPL-3 BitstreamVera"
KEYWORDS="~x86"
SLOT=0
IUSE="examples"

need_php5

pkg_setup() {
	if ! PHPCHECKNODIE="yes" require_php_with_use truetype || \
		! PHPCHECKNODIE="yes" require_php_with_any_use gd gd-external ; then
			die "Re-install ${PHP_PKG} with truetype and either gd or gd-external in USE."
	fi
}

src_install() {
	php-lib-r1_src_install ${PN} `cd ${PN}; find . -type f -print`
	for i in ${PN}/{ChangeLog,README} ; do
		dodoc-php ${i}
		rm -f ${i}
	done
	if use examples ; then
		insinto /usr/share/doc/${CATEGORY}/${PF}
		doins -r demo/
	fi
}
