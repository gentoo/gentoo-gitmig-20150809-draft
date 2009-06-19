# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagvis/nagvis-1.4.1.ebuild,v 1.1 2009/06/19 20:13:16 dertobi123 Exp $

inherit eutils confutils depend.php

DESCRIPTION="NagVis is a visualization addon for the well known network managment system Nagios."
HOMEPAGE="http://www.nagvis.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="automap"

DEPEND=""
RDEPEND=">=net-analyzer/ndoutils-1.4_beta4
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

	grep -Rl "/usr/local" "${S}"/* | xargs sed -i s:/usr/local:/usr:g

	dodir /usr/share/nagvis
	mv "${S}"/{config.php,index.php,nagvis,wui} "${D}"/usr/share/nagvis/

	dodir /var/nagvis
	dosym /var/nagvis /usr/share/nagvis/var
	fowners apache:root /var/nagvis

	dodir /etc/nagvis
	mv "${S}"/etc/* "${D}"/etc/nagvis/
	dosym /etc/nagvis /usr/share/nagvis/etc

	fperms 664 /etc/nagvis/nagvis.ini.php-sample
	fperms 775 /etc/nagvis/maps
	fowners apache:root /etc/nagvis/maps
	fperms 664 /etc/nagvis/maps/*cfg
	fowners apache:root /etc/nagvis/maps/*cfg
}

pkg_postinst() {
	elog "Before running NagVis for the first time, you will need to set up"
	elog "/etc/nagvis/nagvis.ini.php"
	elog "A sample is in"
	elog "/etc/nagvis/nagvis.ini.php-sample"
}
