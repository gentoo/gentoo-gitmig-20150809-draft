# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Maintainer: Tim Raedisch <tim.raedisch@udo.edu>
# $Header: /var/cvsroot/gentoo-x86/net-www/phpBB/phpBB-2.0.6-r1.ebuild,v 1.6 2004/01/04 18:07:43 mholzer Exp $

S=${WORKDIR}/${PN}2
DESCRIPTION="phpBB is a high powered, fully scalable, and highly customisable open-source bulletin board package."
HOMEPAGE="http://www.phpbb.com/"
SRC_URI="mirror://sourceforge/phpbb/${P}.tar.bz2"
RESTRICT="nomirror"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND=">=sys-devel/patch-2.5.9"
RDEPEND="virtual/php"

inherit webapp-apache
webapp-detect || NO_WEBSERVER=1

pkg_setup() {
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
	epatch ${FILESDIR}/${P}-security.patch || die "Security patch failed"
}

src_install() {
	webapp-mkdirs

	dodir "${HTTPD_ROOT}/phpbb"
	cp -a * "${D}/${HTTPD_ROOT}/phpbb"
	dodoc ${S}/docs/*

	cd "${D}/${HTTPD_ROOT}"
	chown -R "${HTTPD_USER}:${HTTPD_GROUP}" "${D}/${HTTPD_ROOT}/phpbb"
}
