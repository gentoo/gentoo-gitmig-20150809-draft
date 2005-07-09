# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/zabbix-frontend/zabbix-frontend-1.1_alpha7.ebuild,v 1.2 2005/07/09 18:33:24 swegener Exp $

inherit eutils webapp

MY_P=${PN//-frontend/}
MY_PV=${PV//_/}
DESCRIPTION="Zabbix php frontend"

HOMEPAGE="http://zabbix.com/"
SRC_URI="mirror://sourceforge/zabbix/${MY_P}-${MY_PV}.tar.gz"

LICENSE="GPL-2"

KEYWORDS="~x86 ~sparc ~amd64"

RDEPEND="virtual/php"

S=${WORKDIR}/${MY_P}-${MY_PV}/frontends

src_install() {
	webapp_src_preinst

	cp -R php/* "${D}/${MY_HTDOCSDIR}"

	webapp_src_install
}

pkg_postinst(){
	einfo
	einfo "For setting the SQL server settings, see include/db.inc.php"
	einfo
}
