# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/mantisbt/mantisbt-1.1.1.ebuild,v 1.1 2008/01/22 16:24:17 pva Exp $

inherit eutils webapp depend.php

IUSE="bundled-adodb"
MY_P=mantis-${PV}

DESCRIPTION="PHP/MySQL/Web based bugtracking system"
HOMEPAGE="http://www.mantisbt.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

S=${WORKDIR}/${MY_P}

KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND="
	virtual/httpd-php
	virtual/httpd-cgi
	!bundled-adodb? ( dev-php/adodb )
"

LICENSE="GPL-2"

pkg_setup() {
	webapp_pkg_setup
	has_php
	require_php_with_use pcre
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	if ! use bundled-adodb ; then
		sed -i -e \
			"s:require_once( 'adodb/adodb.inc.php' );:require_once( \$t_core_dir . 'adodb/adodb.inc.php' );:" \
			"${S}"/core/database_api.php
	else
		rm -r "${S}"/core/adodb/
	fi
}

src_install() {
	webapp_src_preinst
	rm doc/{LICENSE,INSTALL}
	dodoc doc/* packages/mantis-httpd.conf

	rm -rf doc packages
	mv config_inc.php.sample config_inc.php
	cp -R . "${D}"/${MY_HTDOCSDIR}

	webapp_configfile ${MY_HTDOCSDIR}/config_inc.php
	webapp_postinst_txt en "${FILESDIR}"/postinstall-en-1.0.0.txt
	webapp_src_install
}
