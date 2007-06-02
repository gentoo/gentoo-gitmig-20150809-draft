# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/phpwebsite/phpwebsite-1.2.0.ebuild,v 1.1 2007/06/02 05:33:52 rl03 Exp $

inherit webapp depend.php

MY_PV=${PV//./_}
DESCRIPTION="phpWebSite Content Management System"
HOMEPAGE="http://phpwebsite.appstate.edu"
SRC_URI="http://phpwebsite.appstate.edu/downloads/stable/full/1.x.x/${PN}_${MY_PV}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="~alpha ~ppc ~sparc ~x86"
IUSE=""

S="${WORKDIR}"/${PN}_${MY_PV}

need_php

src_install() {
	webapp_src_preinst

	dodoc README docs/*

	cp -r * "${D}/${MY_HTDOCSDIR}"

	# Files that need to be owned by webserver
	webapp_serverowned ${MY_HTDOCSDIR}/config
	webapp_serverowned ${MY_HTDOCSDIR}/config/core
	webapp_serverowned ${MY_HTDOCSDIR}/files
	webapp_serverowned ${MY_HTDOCSDIR}/images
	webapp_serverowned ${MY_HTDOCSDIR}/images/mod
	webapp_serverowned ${MY_HTDOCSDIR}/mod
	webapp_serverowned ${MY_HTDOCSDIR}/logs
	webapp_serverowned ${MY_HTDOCSDIR}/templates
	webapp_serverowned ${MY_HTDOCSDIR}/javascript/modules

#	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}
