# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/mythweb/mythweb-0.20.2_p15488.ebuild,v 1.1 2008/01/24 16:04:40 cardoe Exp $

ESVN_PROJECT="mythplugins"

inherit mythtv webapp depend.php subversion

DESCRIPTION="PHP scripts intended to manage MythTV from a web browser."
IUSE=""
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND="dev-perl/DBI
		dev-perl/DBD-mysql"

need_php5_httpd

pkg_setup() {
	webapp_pkg_setup
	require_php_with_use session mysql pcre posix
}

src_unpack() {
	subversion_src_unpack
}

src_compile() {
	:
}

src_install() {
	webapp_src_preinst

	cd "${S}/mythweb"
	dodoc README TODO

	dodir "${MY_HTDOCSDIR}"/data

	cp -R [[:lower:]]* .htaccess "${D}"${MY_HTDOCSDIR}

	webapp_serverowned "${MY_HTDOCSDIR}"/data
	webapp_serverowned "${MY_HTDOCSDIR}"/.htaccess

	webapp_configfile "${MY_HTDOCSDIR}"/.htaccess

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en-0.20.txt

	webapp_src_install
}
