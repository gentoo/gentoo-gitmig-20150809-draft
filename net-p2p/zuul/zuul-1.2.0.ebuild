# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Maintainer: Don Seiler <rizzo@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-p2p/zuul/zuul-1.2.0.ebuild,v 1.3 2003/12/15 20:33:39 stuart Exp $

inherit webapp-apache

DESCRIPTION="Zuul is yet another PHP front-end for mldonkey."
HOMEPAGE="http://zuul.sourceforge.net"
SRC_URI="mirror://sourceforge/zuul/${P}.tar.gz"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha"
DEPEND=""
RDEPEND=">=mod_php-4.1
	>=net-p2p/mldonkey-2.5"
IUSE=""

webapp-detect || NO_WEBSERVER=1

pkg_setup() {
	webapp-pkg_setup "${NO_WEBSERVER}"
	einfo "Installing for ${WEBAPP_SERVER}"
}

src_install() {
	webapp-mkdirs

	dodir "${HTTPD_ROOT}/zuul"
	cp -a * "${D}/${HTTPD_ROOT}/zuul"
	dodoc ${S}/docs/*

	chown -R "${HTTPD_USER}:${HTTPD_GROUP}" "${D}/${HTTPD_ROOT}/zuul"
}

pkg_postinst() {
	einfo
	einfo "Installation complete."
	einfo
	einfo "You may need to configure zuul by editing"
	einfo "${HTTPD_ROOT}/zuul/conf/config.php and"
	einfo "${HTTPD_ROOT}/zuul/bin/startup.sh."
	einfo
	einfo "http://${HOSTNAME}/zuul"
	einfo
}
