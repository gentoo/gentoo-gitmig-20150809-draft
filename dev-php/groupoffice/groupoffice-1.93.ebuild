# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/groupoffice/groupoffice-1.93.ebuild,v 1.5 2004/01/08 08:40:44 robbat2 Exp $

inherit webapp-apache

S=${WORKDIR}/${P}
DESCRIPTION="Group-Office is a powerfull modular Intranet application framework. It runs *nix using PHP and has several database support."
HOMEPAGE="http://group-office.sourceforge.net/"
SRC_URI="mirror://sourceforge/group-office/${P}.tar.gz
	mirror://sourceforge/group-office/GO-theme-crystal-1.93.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~amd64 ~sparc ~hppa "

DEPEND="virtual/php
	dev-db/mysql"

webapp-detect || NO_WEBSERVER=1

pkg_setup() {
	webapp-pkg_setup "${NO_WEBSERVER}"
	einfo "Installing into ${ROOT}${HTTPD_ROOT}."
}

src_unpack() {
	unpack ${A}
	unpack GO-theme-crystal-1.93.tar.gz
}

src_install() {
	webapp-mkdirs

	local DocumentRoot=${HTTPD_ROOT}
	local destdir=${DocumentRoot}/${PN}

	mkdir -p ${D}${destdir}
	mv ${WORKDIR}/crystal ${S}/themes
	cd ${S}
	dodoc CHANGELOG DEVELOPERS FAQ INSTALL RELEASE README.ldap TODO TRANSLATORS
	rm -rf CHANGELOG FAQ INSTALL README.ldap TODO TRANSLATORS

	cp -r . ${D}${destdir}

	# Fix permissions
	find ${D}${destdir} -type d | xargs chmod 755
	find ${D}${destdir} -type f | xargs chmod 644
}

pkg_postinst() {
	einfo "Follow the instructions at /usr/share/doc/${PF}/INSTALL"
	einfo "to complete the install.  You need to add MySQL users"
	einfo "and configure ${PN}"
	einfo ""
	einfo "Please make sure your php settings have"
	einfo "register_globals = On"
	einfo ""
}
