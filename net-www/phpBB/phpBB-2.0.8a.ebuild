# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/phpBB/phpBB-2.0.8a.ebuild,v 1.1 2004/03/30 20:30:48 stuart Exp $

inherit webapp-apache

DESCRIPTION="phpBB is a high powered, fully scalable, and highly customisable open-source bulletin board package."
HOMEPAGE="http://www.phpbb.com/"
SRC_URI="mirror://sourceforge/phpbb/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"
RESTRICT="nomirror"

DEPEND=">=sys-devel/patch-2.5.9"
RDEPEND="virtual/php"

S=${WORKDIR}/${PN}2

pkg_setup() {
	webapp-detect || NO_WEBSERVER=1

	webapp-pkg_setup "${NO_WEBSERVER}"

	if [ -d ${HTTPD_ROOT}/phpbb ] ; then
		ewarn "You need to unmerge your old phpBB version first."
		ewarn "phpBB will be installed into ${HTTPD_ROOT}/phpbb"
		ewarn "directly instead of a version-dependant directory."
		die "need to unmerge old version first"
	fi

	einfo "Installing for ${WEBAPP_SERVER}"
}

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_install() {
	webapp-mkdirs

	dodir "${HTTPD_ROOT}/phpbb"
	cp -a * "${D}/${HTTPD_ROOT}/phpbb"
	dodoc ${S}/docs/*

	cd "${D}/${HTTPD_ROOT}"
	chown -R "${HTTPD_USER}:${HTTPD_GROUP}" "${D}/${HTTPD_ROOT}/phpbb"
}
