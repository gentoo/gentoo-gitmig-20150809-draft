# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/zuul/zuul-1.1.2.ebuild,v 1.3 2004/04/20 21:05:05 squinky86 Exp $

inherit webapp-apache

DESCRIPTION="Zuul is yet another PHP front-end for mldonkey. It will allow full access to all the features of mldonkey including starting/viewing downloads, viewing uploads, viewing servers, and setting all the options."
HOMEPAGE="http://zuul.sourceforge.net"

# Handle RC versions
MY_PV="${PV/_/-}"
SRC_URI="mirror://sourceforge/zuul/${PN}-${MY_PV}.tar.gz"

SLOT="0"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha"
IUSE=""
RDEPEND="virtual/php
		>=net-p2p/mldonkey-2.5"
DEPEND=""

S="${WORKDIR}/${PN}-${MY_PV}"

pkg_setup() {
	webapp-detect || NO_WEBSERVER=1
	webapp-pkg_setup "${NO_WEBSERVER}"
}

src_compile() {
	echo "Nothing to compile"
}

src_install() {
	cd ${S}
	dodir ${HTTPD_ROOT}/zuul
	cp -r * ${D}/${HTTPD_ROOT}/zuul
}

pkg_postinst() {
	einfo
	einfo "Installation complete."
	einfo
	einfo "You need to configure zuul by editing"
	einfo "${HTTPD_ROOT}/zuul/conf/config.php and"
	einfo "${HTTPD_ROOT}/zuul/bin/startup.sh."
	einfo
	einfo "http://$HOSTNAME/zuul"
	einfo
}
