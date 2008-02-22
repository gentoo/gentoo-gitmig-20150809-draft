# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/phpsysinfo/phpsysinfo-2.5.4.ebuild,v 1.7 2008/02/22 12:21:43 wrobel Exp $

inherit eutils webapp depend.php

DESCRIPTION="phpSysInfo is a nice package that will display your system stats via PHP."
HOMEPAGE="http://phpsysinfo.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

S=${WORKDIR}/${PN}

need_php_httpd

pkg_setup() {
	webapp_pkg_setup
	require_php_with_use pcre xml
}

src_install() {
	webapp_src_preinst

	dodoc README

	insinto "${MY_HTDOCSDIR}"
	doins -r [:dit:]*
	cp config.php.new config.php
	doins config.php

	webapp_configfile ${MY_HTDOCSDIR}/config.php
	webapp_src_install
}
