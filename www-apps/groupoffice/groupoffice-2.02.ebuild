# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/groupoffice/groupoffice-2.02.ebuild,v 1.2 2005/03/28 13:54:54 mholzer Exp $

inherit webapp-apache

S=${WORKDIR}/${PN}-com-${PV}
DESCRIPTION="Group-Office is a powerful modular Intranet application framework. It runs *nix using PHP and has several database support."
HOMEPAGE="http://group-office.sourceforge.net/"
SRC_URI="mirror://sourceforge/group-office/${PN}-com-${PV}.tar.gz
	mirror://sourceforge/group-office/GO-theme-crystal-1.93.tar.gz"
RESTRICT="nomirror"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha amd64 ~sparc ~hppa"

DEPEND="virtual/php
	dev-db/mysql"


pkg_setup() {
	webapp-detect || NO_WEBSERVER=1
	webapp-pkg_setup "${NO_WEBSERVER}"
	if [ -d ${HTTPD_ROOT}/${PN} ] ; then
		ewarn "You need to unmerge your old ${PN} version first."
		ewarn "${PN} will be installed into ${HTTPD_ROOT}/${PN}"
		ewarn "directly instead of a version-dependant directory."
		die "need to unmerge old version first"
	fi

	einfo "Installing into ${ROOT}${HTTPD_ROOT}."
}

src_install() {
	webapp-detect || NO_WEBSERVER=1
	webapp-mkdirs

	local DocumentRoot=${HTTPD_ROOT}
	local destdir=${DocumentRoot}/${PN}

	mkdir -p ${D}${destdir}
	mv ${WORKDIR}/crystal ${S}/themes
	cd ${S}
	dodoc CHANGELOG DEVELOPERS FAQ INSTALL RELEASE README.ldap TODO TRANSLATORS
	rm -rf CHANGELOG FAQ INSTALL README.ldap TODO TRANSLATORS

	cp -r . ${D}${destdir}

	cd "${D}/${HTTPD_ROOT}"
	chown -R "${HTTPD_USER}:${HTTPD_GROUP}" ${PN}
	# Fix permissions
	find ${D}${destdir} -type d | xargs chmod 755
	find ${D}${destdir} -type f | xargs chmod 644
}

pkg_postinst() {
	einfo "Follow the instructions at /usr/share/doc/${PF}/INSTALL"
	einfo "to complete the install.  You need to add MySQL users"
	einfo "and configure ${PN}"
}
