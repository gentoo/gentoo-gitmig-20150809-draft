# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/phpmp/phpmp-0.10.0.ebuild,v 1.2 2004/03/21 09:09:44 mholzer Exp $

inherit webapp-apache

MY_PN="phpMp"
MY_P="${MY_PN}-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="phpMp is a client program for Music Player Daemon (mpd)"
HOMEPAGE="http://www.musicpd.org/"
SRC_URI="mirror://sourceforge/musicpd/${MY_P}.tar.gz"
RESTRICT="nomirror"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE=""

DEPEND=">=net-www/apache-1.3.27-r1
	>=dev-php/mod_php-4.2.3-r2"

PHPMP_DIR="${HTTPD_ROOT}/${MY_PN}"

pkg_setup() {
	webapp-detect || NO_WEBSERVER=1
	webapp-pkg_setup "${NO_WEBSERVER}"
	einfo "Installing into ${ROOT}${HTTPD_ROOT}."
}

src_compile() {
	#we need to have this empty function ... default compile hangs
	echo "Nothing to compile"
}

src_install() {
	webapp-detect || NO_WEBSERVER=1
	webapp-mkdirs

	insinto "${PHPMP_DIR}"
	doins *.php

	chown -R "${HTTPD_USER}:${HTTPD_GROUP}" "${D}/${PHPMP_DIR}"
}

pkg_postinst() {
	einfo "Remember to edit the config file in:"
	einfo " ${PHPMP_DIR}/"
}
