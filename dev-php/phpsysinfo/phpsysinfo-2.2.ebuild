# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/phpsysinfo/phpsysinfo-2.2.ebuild,v 1.3 2005/01/04 12:43:11 corsair Exp $

inherit eutils kernel-mod webapp

MY_PN="phpsysinfo"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="phpSysInfo is a nice package that will display your system stats via PHP."
HOMEPAGE="http://phpsysinfo.sourceforge.net/"
SRC_URI="mirror://sourceforge/phpsysinfo/${MY_P}.tar.gz"
IUSE=""
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha ~hppa ~sparc ~amd64"

DEPEND="$DEPEND >=net-www/apache-1.3.27-r1
	>=dev-php/mod_php-4.2.3-r2"

S=${WORKDIR}/${MY_PN}-dev

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	webapp_src_preinst

	cp -R templates ${D}${MY_HTDOCSDIR}
	cp -R includes ${D}${MY_HTDOCSDIR}
	cp *.php ${D}${MY_HTDOCSDIR}
	cp -R images ${D}${MY_HTDOCSDIR}
	cp -R sample ${D}${MY_HTDOCSDIR}
	cp -R tools ${D}${MY_HTDOCSDIR}

	cp config.php.new ${D}${MY_HTDOCSDIR}/config.php
	webapp_configfile ${MY_HTDOCSDIR}

	dodoc ChangeLog README

	webapp_src_install
}
