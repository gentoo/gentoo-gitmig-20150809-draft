# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/mythweb/mythweb-0.20.1_p14146.ebuild,v 1.4 2007/08/10 20:00:22 cardoe Exp $

inherit mythtv webapp depend.php subversion

ESVN_PROJECT="mythplugins"

DESCRIPTION="PHP scripts intended to manage MythTV from a web browser."
IUSE=""
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND="virtual/httpd-php
		dev-perl/DBI
		dev-perl/DBD-mysql"

pkg_setup() {
	webapp_pkg_setup

	if has_version 'dev-lang/php' ; then
		require_php_with_use session mysql pcre posix
	fi
}

src_unpack() {
	subversion_src_unpack
	cd "${S}/.."
	mythtv-fixes_patch
	cd "${S}"
}

src_compile() {
	echo "Nothing to compile."
}

src_install() {
	webapp_src_preinst

	cd "${S}/mythweb"
	dodoc README TODO

	dodir ${MY_HTDOCSDIR}/data

	cp -R [[:lower:]]* .htaccess ${D}${MY_HTDOCSDIR}

	webapp_serverowned ${MY_HTDOCSDIR}/data
	webapp_serverowned ${MY_HTDOCSDIR}/.htaccess

	webapp_configfile ${MY_HTDOCSDIR}/.htaccess

	webapp_postinst_txt en ${FILESDIR}/postinstall-en-0.20.txt

	webapp_src_install
}
