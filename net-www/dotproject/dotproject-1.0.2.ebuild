# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/dotproject/dotproject-1.0.2.ebuild,v 1.2 2004/07/15 18:52:50 tigger Exp $

inherit webapp

MY_P="${PN}_${PV}-1"
MY_SQL_PV="${PV//\./}"
DESCRIPTION="dotProject is a PHP web-based project management framework"
HOMEPAGE="http://www.dotproject.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
KEYWORDS="~x86"
DEPEND="$DEPEND"
RDEPEND="$RDEPEND"
S=${WORKDIR}/${PN}
LICENSE="BSD"

src_install ()
{
	webapp_src_preinst

	mv includes/config-dist.php includes/config.php
	cp -R * ${D}${MY_HTDOCSDIR}

	webapp_configfile ${MY_HTDOCSDIR}/includes/config.php
	webapp_serverowned ${MY_HTDOCSDIR}/files

	webapp_sqlscript mysql db/${PN}_${MY_SQL_PV}.sql
	webapp_postinst_txt en ${FILESDIR}/${PVR}/install-en.txt
	webapp_hook_script ${FILESDIR}/${PVR}/postinstall.sh

	webapp_src_install
}
