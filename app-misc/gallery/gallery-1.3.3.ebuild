# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gallery/gallery-1.3.3.ebuild,v 1.5 2003/06/29 23:17:15 aliz Exp $

DESCRIPTION="Web based (PHP Script) photo album viewer/creator."
HOMEPAGE="http://gallery.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="x86 ~ppc ~sparc ~alpha"
DEPEND=">=net-www/apache-1.3.24-r1
	>=dev-php/mod_php-4.1.2-r5
	>=media-gfx/jhead-1.6
	>=media-gfx/imagemagick-5.4.9.1-r1"

S="${WORKDIR}/${PN}"
DST_PATH="/home/httpd/htdocs/gallery"

src_install() {
	insinto ${DST_PATH}
	doins *.{php,sh}

	insinto ${DST_PATH}/classes
	doins classes/*.php

	insinto ${DST_PATH}/classes/database/mysql
	doins classes/database/mysql/*.php

	insinto ${DST_PATH}/classes/gallery
	doins classes/gallery/*.php

	insinto ${DST_PATH}/classes/nuke5
	doins classes/nuke5/*.php

	insinto ${DST_PATH}/classes/postnuke
	doins classes/postnuke/*.php

	insinto ${DST_PATH}/classes/postnuke0.7.1
	doins classes/postnuke0.7.1/*.php

	insinto ${DST_PATH}/css
	doins css/*.default

	insinto ${DST_PATH}/errors
	doins errors/*.php

	insinto ${DST_PATH}/html
	doins html/*.inc

	insinto ${DST_PATH}/html_wrap
	doins html_wrap/*.default

	insinto ${DST_PATH}/images
	doins images/*.{jpg,gif,png}

	insinto ${DST_PATH}/java
	doins java/*.jar

	insinto ${DST_PATH}/js
	doins js/*.js

	insinto ${DST_PATH}/layout
	doins layout/*.inc

	insinto ${DST_PATH}/platform
	doins platform/*.php

	insinto ${DST_PATH}/setup
	doins setup/*.{php,inc,template,txt} setup/.htaccess

	dodoc AUTHORS ChangeLog README LICENSE.txt todo UPGRADING
}


pkg_postinst() {
	chown -R apache.apache ${DST_PATH}
	chown root.root ${DST_PATH}/secure.sh ${DST_PATH}/configure.sh
	chmod 700 ${DST_PATH}/secure.sh ${DST_PATH}/configure.sh

	einfo
	einfo "For new installations  point your browser to http://www.yourhost.com/gallery/setup/"
	einfo "and follow the instructions."
        einfo "-----------------------------------------------------------------------------------"
        einfo "For upgrades, just run  # ${DST_PATH}/secure.sh" 
	einfo
}

