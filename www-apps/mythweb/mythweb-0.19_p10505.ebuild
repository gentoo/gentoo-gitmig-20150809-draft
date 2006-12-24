# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/mythweb/mythweb-0.19_p10505.ebuild,v 1.5 2006/12/24 08:12:53 cardoe Exp $

inherit webapp depend.php

PATCHREV="${PV#*_p}"
MY_PV="${PV%_*}"

DESCRIPTION="PHP scripts intended to manage MythTV from a web browser."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://ftp.osuosl.org/pub/mythtv/mythplugins-${MY_PV}.tar.bz2
	http://dev.gentoo.org/~cardoe/files/mythplugins-${MY_PV}-rev${PATCHREV}.patch.bz2"
IUSE=""
LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86"

RDEPEND="virtual/httpd-php"

S="${WORKDIR}/mythplugins-${MY_PV}/${PN}"

pkg_setup() {
	webapp_pkg_setup

	if has_version 'dev-lang/php' ; then
		require_php_with_use session mysql pcre
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	#Fixes of the bugs found in the 0.19 release
	cd ..
	epatch "${WORKDIR}"/mythplugins-${MY_PV}-rev${PATCHREV}.patch
}

src_install() {
	webapp_src_preinst

	dodoc README TODO

	dodir ${MY_HTDOCSDIR}/data

	cp -R [[:lower:]]* .htaccess ${D}${MY_HTDOCSDIR}

	webapp_serverowned ${MY_HTDOCSDIR}/data

	webapp_configfile ${MY_HTDOCSDIR}/config/conf.php
	webapp_configfile ${MY_HTDOCSDIR}/.htaccess
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}
