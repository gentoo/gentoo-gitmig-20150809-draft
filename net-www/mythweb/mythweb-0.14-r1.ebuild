# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mythweb/mythweb-0.14-r1.ebuild,v 1.1 2004/04/11 17:26:09 aliz Exp $

inherit webapp-apache

DESCRIPTION="PHP scripts intended to manage MythTV from a web browser."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND=">=dev-php/mod_php-4.2"

webapp-detect || NO_WEBSERVER=1

pkg_setup() {
#	webapp-pkg_setup "${NO_WEBSERVER}"
#	webapp-check-php mysql
	einfo "Installing ${PN} into ${HTTPD_ROOT}"
}

src_install() {
	webapp-mkdirs

	dodir "${HTTPD_ROOT}"
	cp -R "${S}" "${D}${HTTPD_ROOT}/${PN}"

	keepdir "${HTTPD_ROOT}/${PN}/"{php_sessions,image_cache}
	fowners "${HTTPD_USER}:${HTTPD_GROUP}" "${HTTPD_ROOT}/${PN}/"{php_sessions,image_cache}
	dodoc README

	# protect configfiles
	echo "CONFIG_PROTECT=${HTTPD_ROOT}/${PN}/config" > ${T}/27mythweb
	insinto /etc/env.d ; doins ${T}/27mythweb
}

pkg_postinst() {
	einfo "You should modify ${HTTPD_ROOT}/${PN}/config/conf.php"
	einfo "to fit your needs."
	echo
}
