# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/ids/ids-0.82.ebuild,v 1.2 2005/07/10 01:16:17 swegener Exp $

inherit webapp-apache

DESCRIPTION="Web based (PHP Script) photo album viewer/creator"
HOMEPAGE="http://ids.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~x86"
RDEPEND=">=net-www/apache-1.3.27
	dev-perl/Archive-Zip
	>=dev-php/mod_php-4.1.3
	dev-perl/ImageInfo
	>=media-gfx/imagemagick-5.4.9.1-r1"

pkg_setup() {
	webapp-detect || NO_WEBSERVER=1
	webapp-pkg_setup "${NO_WEBSERVER}"
	einfo "Installing into ${ROOT}${HTTPD_ROOT}."
}

src_install() {
	webapp-detect || NO_WEBSERVER=1
	webapp-mkdirs

	local DocumentRoot=${HTTPD_ROOT}
	local destdir=${DocumentRoot}/${PN}
	dodir ${destdir}
	#Do not remove docs as it will not work without
	dodoc CREDITS ChangeLog PATCH.SUBMISSION README

	cp -r . ${D}/${HTTPD_ROOT}/${PN}
	cd ${D}/${HTTPD_ROOT}
	chown -R ${HTTPD_USER}:${HTTPD_GROUP} ${PN}
	# Fix permissions
	find ${D}${destdir} -type d | xargs chmod 755
	find ${D}${destdir} -type f | xargs chmod 644

}

pkg_postinst() {
	einfo "to make this working you have to enable"
	einfo "cgi in ${HTTPD_ROOT}/${PN}"
	einfo
	einfo "this could be done by a simple"
	einfo " 	cd ${HTTPD_ROOT}/${PN}"
	einfo "		echo \"Options ExecCGI\" > .htaccess"
}
