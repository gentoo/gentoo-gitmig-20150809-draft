# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/phpmp2/phpmp2-0.11.0.ebuild,v 1.1 2006/01/03 16:34:46 rl03 Exp $

inherit webapp

MY_PN=${PN/m/M}
DESCRIPTION="phpMp2 is another web-based client for MPD"
HOMEPAGE="http://musicpd.org/phpMp2.shtml"
SRC_URI="http://mercury.chem.pitt.edu/~shank/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~x86"
S=${WORKDIR}/${MY_PN}

IUSE="gd"

RDEPEND="
	virtual/php
	gd? ( media-libs/gd )
	net-www/apache"

src_install () {
	webapp_src_preinst

	dodoc README TODO
	cp -R . ${D}/${MY_HTDOCSDIR}

	webapp_serverowned "${MY_HTDOCSDIR}/config.php"
	webapp_configfile "${MY_HTDOCSDIR}/config.php"

	webapp_src_install
}
