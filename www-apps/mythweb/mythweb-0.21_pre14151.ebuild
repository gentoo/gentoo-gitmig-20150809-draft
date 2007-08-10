# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/mythweb/mythweb-0.21_pre14151.ebuild,v 1.1 2007/08/10 21:01:57 cardoe Exp $

inherit mythtv webapp depend.php subversion

DESCRIPTION="PHP scripts intended to manage MythTV from a web browser."
IUSE=""
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND="virtual/httpd-php
		dev-perl/DBI
		dev-perl/DBD-mysql"

S="${WORKDIR}/${PN}"

pkg_setup() {
	webapp_pkg_setup

	if has_version 'dev-lang/php' ; then
		require_php_with_use session mysql pcre posix
	fi
}

src_unpack() {
	subversion_src_unpack
}

src_compile() {
	echo ""
}

src_install() {
	webapp_src_preinst

	dodoc README TODO

	dodir ${MY_HTDOCSDIR}/data

	cp -R ${S}/${PN}/[[:lower:]]* ${D}${MY_HTDOCSDIR}
	cp ${S}/mythweb.conf.apache ${MY_SERVERCONFIGDIR}/

	webapp_serverowned ${MY_HTDOCSDIR}/data

	webapp_configfile ${MY_SERVERCONFIGDIR}/mythweb.conf.apache

	webapp_postinst_txt en ${FILESDIR}/postinstall-en-0.21.txt

	webapp_src_install
}
