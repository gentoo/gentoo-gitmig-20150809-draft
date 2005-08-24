# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/egroupware/egroupware-1.0.0.009.ebuild,v 1.6 2005/08/24 19:20:27 hparker Exp $

inherit webapp eutils

MY_P=eGroupWare-${PV}
S=${WORKDIR}/${PN}

DESCRIPTION="Web-based GroupWare suite"
HOMEPAGE="http://www.eGroupWare.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="alpha amd64 ~hppa ppc ~sparc x86"
IUSE="gd ldap"

RDEPEND="virtual/php
	|| ( >=dev-db/mysql-3.23 >=dev-db/postgresql-7.2 )
	ldap? ( net-nds/openldap )
	gd? ( media-libs/gd )
	net-www/apache"

pkg_setup () {
	webapp_pkg_setup
	if useq ldap; then
		if ! built_with_use virtual/php ldap; then
			ewarn "PHP needs to be compiled with LDAP support."
		fi
	fi
	if ! built_with_use virtual/php imap; then
		ewarn "PHP needs to be compiled with IMAP support."
		die
	fi
	einfo "Please make sure that your PHP is compiled with MySQL|PostgreSQL support"
	einfo
	einfo "Consider installing an MTA if you want to use eGW's mail capabilities."
}

src_unpack() {
	unpack ${A}
	cd ${S}
	# remove CVS directories
	find . -type d -name 'CVS' -print | xargs rm -rf
}

src_install() {
	webapp_src_preinst
	cp -r . ${D}/${MY_HTDOCSDIR}

	webapp_serverowned ${MY_HTDOCSDIR}/fudforum
	webapp_serverowned ${MY_HTDOCSDIR}/phpgwapi/images

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_src_install
}
