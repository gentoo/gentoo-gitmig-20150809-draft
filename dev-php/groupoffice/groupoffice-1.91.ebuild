# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/groupoffice/groupoffice-1.91.ebuild,v 1.1 2003/10/12 22:03:25 mholzer Exp $

S=${WORKDIR}/${PN}
HTTPD_ROOT="/home/httpd/htdocs"
HTTPD_USER="apache"
HTTPD_GROUP="apache"

DESCRIPTION="Group-Office is a powerfull modular Intranet application framework. It runs *nix using PHP and has several database support."
HOMEPAGE="http://group-office.sourceforge.net/"
SRC_URI="mirror://sourceforge/group-office/${P}.tar.gz
	mirror://sourceforge/group-office/GO-theme-Crystal-1.9.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~amd64 ~sparc ~hppa ~arm"

DEPEND="virtual/php
	dev-db/mysql"

pkg_setup() {
	if [ -L ${HTTPD_ROOT}/${PN} ] ; then
		ewarn "You need to unmerge your old ${PN} version first."
		ewarn "${PN} be installed into ${HTTPD_ROOT}/${PN}"
		ewarn "directly instead of a version-dependant directory."
		die "need to unmerge old version first"
	fi
}

src_unpack() {
	unpack ${A}
	unpack GO-theme-Crystal-1.9.tar.gz
}

src_install() {
	dodir ${HTTPD_ROOT}/${PN}
	cd ${WORKDIR}
	mv ${P} ${PN}
	mv ${WORKDIR}/crystal ${S}/themes
	cd ${S}
	dodoc CHANGELOG DEVELOPERS FAQ INSTALL RELEASE README.ldap TODO TRANSLATORS
	rm -rf CHANGELOG DEVELOPERS FAQ INSTALL RELEASE README.ldap TODO TRANSLATORS
	cd ${WORKDIR}

	cp -r . ${D}/${HTTPD_ROOT}
	cd ${D}/${HTTPD_ROOT}
	chown -R ${HTTPD_USER}.${HTTPD_GROUP} ${PN}
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
