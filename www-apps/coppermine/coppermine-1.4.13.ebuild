# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/coppermine/coppermine-1.4.13.ebuild,v 1.1 2007/09/18 04:20:51 wrobel Exp $

inherit webapp versionator depend.php

DESCRIPTION="Feature rich web picture gallery script written in PHP using GD or ImageMagick lib with a MySQL backend."
HOMEPAGE="http://coppermine.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/cpg${PV}.zip"

LICENSE="GPL-2"
KEYWORDS="~sparc ~x86 ~amd64"
IUSE="imagemagick"

DEPEND="app-arch/unzip"

RDEPEND=">=www-servers/apache-2.0
	virtual/httpd-php
	imagemagick? ( media-gfx/imagemagick )"

S=${WORKDIR}/cpg$(delete_all_version_separators)

pkg_setup() {
	webapp_pkg_setup
	if ! PHPCHECKNODIE="yes" require_php_with_use mysql ; then
		eerror
		eerror "${PHP_PKG} needs to be re-installed with mysql USE-flag"
		eerror
		die "Re-install ${PHP_PKG}"
	fi
}

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
