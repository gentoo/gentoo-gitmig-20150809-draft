# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/mantisbt/mantisbt-1.0.8.ebuild,v 1.1 2007/08/12 07:28:50 pva Exp $

inherit eutils webapp

IUSE="bundled-adodb"
MY_P=mantis-${PV}

DESCRIPTION="PHP/MySQL/Web based bugtracking system"
HOMEPAGE="http://www.mantisbt.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

S="${WORKDIR}/${MY_P}"

KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND="
	www-servers/apache
	virtual/httpd-php
	!bundled-adodb? ( dev-php/adodb )
"

LICENSE="GPL-2"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# http://www.mantisbt.org/bugs/view.php?id=8256
	epatch "${FILESDIR}"/${P}-avoid-XS-type-in-schema.php.patch

	if use bundled-adodb ; then
		sed -ie \
			"s:require_once( 'adodb/adodb.inc.php' );:require_once( \$t_core_dir . 'adodb/adodb.inc.php' );:" \
			"${S}"/core/database_api.php
	else
		rm -r "${S}"/core/adodb/
	fi

	# Fix permitions. Should be fixed in 1.0.9
	find "${S}" -type f -exec chmod 644 \{\} \;
	find "${S}" -type d -exec chmod 755 \{\} \;
}

src_install() {
	webapp_src_preinst
	rm doc/{LICENSE,INSTALL}
	dodoc doc/*

	cp -R . "${D}"/${MY_HTDOCSDIR}
	rm -rf "${D}"/${MY_HTDOCSDIR}/doc

	mv "${D}"/${MY_HTDOCSDIR}/config_inc.php.sample "${D}"/${MY_HTDOCSDIR}/config_inc.php

	webapp_configfile ${MY_HTDOCSDIR}/config_inc.php
	webapp_postinst_txt en ${FILESDIR}/postinstall-en-1.0.0.txt
	webapp_src_install
}
