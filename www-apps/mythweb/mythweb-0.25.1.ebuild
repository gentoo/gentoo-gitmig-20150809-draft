# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/mythweb/mythweb-0.25.1.ebuild,v 1.1 2012/07/12 02:59:19 cardoe Exp $

EAPI=4

inherit webapp depend.php

# Release version
MY_PV="${PV%_*}"

DESCRIPTION="PHP scripts intended to manage MythTV from a web browser."
HOMEPAGE="http://www.mythtv.org"
LICENSE="GPL-2"
SRC_URI="ftp://ftp.osuosl.org/pub/mythtv/mythplugins-${MY_PV}.tar.bz2"
IUSE=""
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND="dev-lang/php:5.3[json,mysql,session,posix]
	dev-perl/DBI
	dev-perl/DBD-mysql
	dev-perl/HTTP-Date
	dev-perl/Net-UPnP"

DEPEND="${RDEPEND}"

S="${WORKDIR}/mythplugins-${MY_PV}/${PN}"

need_httpd_cgi
need_php5_httpd

src_configure() {
	:
}

src_compile() {
	:
}

src_install() {
	webapp_src_preinst

	cd "${S}"
	dodoc README INSTALL

	dodir "${MY_HTDOCSDIR}"/data

	insinto "${MY_HTDOCSDIR}"
	doins -r [[:lower:]]*

	webapp_configfile "${MY_HTDOCSDIR}"/mythweb.conf.{apache,lighttpd}

	webapp_serverowned "${MY_HTDOCSDIR}"/data

	webapp_postinst_txt en "${FILESDIR}"/0.24-postinstall-en.txt

	webapp_src_install

	fperms 755 /usr/share/webapps/mythweb/${PV}/htdocs/mythweb.pl
}
