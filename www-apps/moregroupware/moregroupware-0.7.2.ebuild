# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/moregroupware/moregroupware-0.7.2.ebuild,v 1.9 2008/02/04 08:27:50 hollow Exp $

inherit webapp depend.php

S=${WORKDIR}/${PN}

DESCRIPTION="more.groupware is another web based groupware"
HOMEPAGE="http://moregroupware.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-core-${PV}.tar.gz"

LICENSE="X11 GPL-2"
KEYWORDS="~x86 ppc"
IUSE=""

RDEPEND="virtual/httpd-cgi"

need_php

pkg_setup() {
	require_php_sapi_from apache2 cgi
	webapp_pkg_setup
}

src_install() {
	webapp_src_preinst

	rm -f docs/LICENSE
	dodoc docs/*
	rm -rf docs

	cp -R . "${D}"/${MY_HTDOCSDIR}

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	webapp_hook_script "${FILESDIR}"/reconfig

	webapp_src_install
}
