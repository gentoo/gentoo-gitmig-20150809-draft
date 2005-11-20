# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/phpsysinfo/phpsysinfo-2.4.1.ebuild,v 1.1 2005/11/20 11:53:16 stuart Exp $

inherit eutils webapp

MY_PN="phpSysInfo"
MY_P="${MY_PN}-${PVR}"
DESCRIPTION="phpSysInfo is a nice package that will display your system stats via PHP."
HOMEPAGE="http://phpsysinfo.sourceforge.net/"
SRC_URI="mirror://sourceforge/phpsysinfo/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="$DEPEND
	>=virtual/httpd-php-4.3.8"

S=${WORKDIR}/${MY_PN}-${PV}

# src_unpack() {
#	unpack ${A}
#	cd ${S}
#	epatch ${FILESDIR}/${P}-xss-and-path.patch
#	epatch ${FILESDIR}/${P}-sparc.patch
#	epatch ${DISTDIR}/${P}.bind.patch
#}

src_install() {
	webapp_src_preinst

	cp -R templates ${D}${MY_HTDOCSDIR} || die "cp failed"
	cp -R includes ${D}${MY_HTDOCSDIR} || die "cp failed"
	cp *.php ${D}${MY_HTDOCSDIR} || die "cp failed"
	cp -R images ${D}${MY_HTDOCSDIR} || die "cp failed"

	cp config.php.new ${D}${MY_HTDOCSDIR}/config.php || die "cp failed"
	webapp_configfile ${MY_HTDOCSDIR}

	dodoc ChangeLog README

	webapp_src_install
}
