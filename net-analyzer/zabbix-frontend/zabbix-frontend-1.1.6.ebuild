# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/zabbix-frontend/zabbix-frontend-1.1.6.ebuild,v 1.1 2007/02/12 01:01:01 wschlich Exp $

inherit eutils webapp depend.php

MY_P=${PN//-frontend/}
MY_PV=${PV//_/}
DESCRIPTION="Zabbix PHP web-frontend"

HOMEPAGE="http://www.zabbix.com/"
SRC_URI="mirror://sourceforge/zabbix/${MY_P}-${MY_PV}.tar.gz"

LICENSE="GPL-2"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"

need_php_httpd

S=${WORKDIR}/${MY_P}-${MY_PV}/frontends

pkg_setup() {
	webapp_pkg_setup
	require_gd
}

src_install() {
	webapp_src_preinst
	cp -R php/* "${D}/${MY_HTDOCSDIR}"
	webapp_postinst_txt en ${FILESDIR}/postinstall-en-${MY_PV}.txt
	webapp_configfile ${MY_HTDOCSDIR}/include/db.inc.php
	webapp_src_install
}
