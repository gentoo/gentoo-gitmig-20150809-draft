# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/phpmp/phpmp-0.9.1.ebuild,v 1.2 2003/12/14 23:29:24 spider Exp $

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

DEPEND=">=net-www/apache-1.3.27-r1 >=mod_php-4.2.3-r2"

inherit webapp-apache
webapp-detect || NO_WEBSERVER=1

PHPMP_DIR="${HTTPD_ROOT}/${MY_PN}"

pkg_setup() {
	webapp-pkg_setup "${NO_WEBSERVER}"
}

src_compile() {
	#we need to have this empty function ... default compile hangs
	echo "Nothing to compile"
}

src_install() {
	insinto "${PHPMP_DIR}"
	doins *.php

	chown -R "${HTTPD_USER}:${HTTPD_GROUP}" "${D}/${PHPMP_DIR}"
}

pkg_postinst() {
	einfo "Remember to edit the config file in:"
	einfo " ${PHPMP_DIR}/"
}
