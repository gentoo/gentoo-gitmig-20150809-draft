# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/dotproject/dotproject-2.1_rc2.ebuild,v 1.1 2007/08/09 11:50:10 wrobel Exp $

inherit webapp depend.php

MY_P=${PN}_${PV/_/-}

DESCRIPTION="dotProject is a PHP web-based project management framework"
HOMEPAGE="http://www.dotproject.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

S=${WORKDIR}/${PN}
LICENSE="GPL-2"

need_php

src_install () {
	webapp_src_preinst

	dodoc ChangeLog README

	mv includes/config-dist.php includes/config.php
	cp -R * ${D}${MY_HTDOCSDIR}

	webapp_serverowned ${MY_HTDOCSDIR}/includes/config.php
	webapp_serverowned ${MY_HTDOCSDIR}/files
	webapp_serverowned ${MY_HTDOCSDIR}/files/temp
	webapp_serverowned ${MY_HTDOCSDIR}/locales/en

	webapp_postinst_txt en ${FILESDIR}/install-en.txt
	webapp_src_install
}
