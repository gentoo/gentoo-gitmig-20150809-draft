# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/coppermine/coppermine-1.4.5.ebuild,v 1.1 2006/04/24 13:03:38 rl03 Exp $

inherit webapp versionator

DESCRIPTION="Feature rich web picture gallery script written in PHP using GD or ImageMagick lib with a MySQL backend."
HOMEPAGE="http://coppermine.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/cpg${PV}.zip"

LICENSE="GPL-2"
KEYWORDS="~sparc ~x86"
IUSE="imagemagick"

DEPEND="app-arch/unzip"

RDEPEND=">=net-www/apache-1.3.24-r1
	virtual/httpd-php
	dev-db/mysql
	imagemagick? ( media-gfx/imagemagick )"

S=${WORKDIR}/cpg$(delete_all_version_separators)

src_install() {
	webapp_src_preinst

	local docs="CHANGELOG COPYING"
	dodoc ${docs}

	einfo "Installing main files"
	cp -r * ${D}${MY_HTDOCSDIR}
	einfo "Done"

	# owned files
	dodir ${MY_HTDOCSDIR}/albums
	webapp_serverowned ${MY_HTDOCSDIR}/albums
	webapp_serverowned ${MY_HTDOCSDIR}/albums/userpics
	webapp_serverowned ${MY_HTDOCSDIR}/albums/edit
	webapp_serverowned ${MY_HTDOCSDIR}/include

	dohtml docs/*
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}
