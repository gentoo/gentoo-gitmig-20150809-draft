# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/mythweb/mythweb-0.20_p11188.ebuild,v 1.2 2006/09/16 06:05:08 cardoe Exp $

inherit webapp depend.php

# Release version
MY_PV="${PV%_*}"

# SVN revision number to increment from the released version
if [ "x${MY_PV}" != "x${PV}" ]; then
	PATCHREV="${PV##*_p}"
fi

DESCRIPTION="PHP scripts intended to manage MythTV from a web browser."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://ftp.osuosl.org/pub/mythtv/mythplugins-${MY_PV}.tar.bz2"
if [ -n "${PATCHREV}" ] ; then
	SRC_URI="${SRC_URI} http://dev.gentoo.org/~cardoe/files/mythtv/mythplugins-${MY_PV}_svn${PATCHREV}.patch.bz2"
fi
IUSE=""
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

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
	cd "${S}"

	if [ -n "$PATCHREV" ]; then
		epatch ${WORKDIR}/mythplugins-${MY_PV}_svn${PATCHREV}.patch
	fi

}

src_install() {
	webapp_src_preinst

	dodoc README TODO

	dodir ${MY_HTDOCSDIR}/data

	cp -R [[:lower:]]* .htaccess ${D}${MY_HTDOCSDIR}

	webapp_serverowned ${MY_HTDOCSDIR}/data

	webapp_configfile ${MY_HTDOCSDIR}/.htaccess
	webapp_configfile ${MY_HTDOCSDIR}/.htpasswd

	webapp_postinst_txt en ${FILESDIR}/postinstall-en-0.20.txt

	webapp_src_install
}
