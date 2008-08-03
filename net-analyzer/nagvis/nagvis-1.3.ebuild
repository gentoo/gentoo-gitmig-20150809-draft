# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagvis/nagvis-1.3.ebuild,v 1.1 2008/08/03 15:12:28 dertobi123 Exp $

inherit eutils confutils depend.php

DESCRIPTION="NagVis is a visualization addon for the well known network managment system Nagios."
HOMEPAGE="http://www.nagvis.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="automap"

DEPEND=">=net-analyzer/nagios-3
		>=net-analyzer/ndoutils-1.4_beta4
		automap? ( >=media-gfx/graphviz-2.14 )"

need_php_httpd

pkg_setup() {
	confutils_require_built_with_all dev-lang/php gd mysql unicode
}

src_install() {
	for docfile in README INSTALL
	do
		dodoc ${docfile}
		rm ${docfile}
	done

	dodir /usr/share
	grep -Rl "/usr/local" "${S}"/* | xargs sed -i s:/usr/local:/usr:g
	mv "${S}" "${D}"/usr/share/nagvis
	chmod 664 "${D}"/usr/share/nagvis/etc/config.ini.php.dist
	chmod 775 "${D}"/usr/share/nagvis/images/maps
	chmod 664 "${D}"/usr/share/nagvis/images/maps/*
	chmod 775 "${D}"/usr/share/nagvis/etc/maps
	chmod 664 "${D}"/usr/share/nagvis/etc/maps/*
}
pkg_postinst() {
	elog "Before running NagVis for the first time, you will need to set up"
	elog "/usr/share/nagvis/nagvis/etc/config.ini.php"
	elog "A sample is in"
	elog "/usr/share/nagvis/nagvis/etc/config.ini.php.dist"
}


