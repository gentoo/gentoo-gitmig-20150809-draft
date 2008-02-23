# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/phpgroupware/phpgroupware-0.9.16.012.ebuild,v 1.5 2008/02/23 21:15:05 hollow Exp $

inherit webapp eutils depend.php

DESCRIPTION="intranet/groupware tool and application framework"
HOMEPAGE="http://www.phpgroupware.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

IUSE=""
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ~hppa ppc ~sparc ~x86"

need_httpd_cgi
need_php_httpd

S="${WORKDIR}"/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	ecvs_clean
}

src_install() {
	webapp_src_preinst

	insinto "${MY_HTDOCSDIR}"
	doins -r .
	dohtml ${PN}/doc/en_US/html/admin/*.html

	webapp_serverowned "${MY_HTDOCSDIR}"/fudforum

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	webapp_src_install
}
