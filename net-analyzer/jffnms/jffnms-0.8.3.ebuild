# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/jffnms/jffnms-0.8.3.ebuild,v 1.2 2006/10/11 22:32:14 jokey Exp $

inherit eutils depend.php

DESCRIPTION="Network Management and Monitoring System."
HOMEPAGE="http://www.jffnms.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="mysql postgres snmp"

DEPEND="net-www/apache
	mysql? ( dev-db/mysql )
	postgres? ( dev-db/postgresql )
	net-analyzer/rrdtool
	media-libs/gd
	dev-php/PEAR-PEAR
	snmp? ( net-analyzer/net-snmp )
	sys-apps/diffutils
	app-mobilephone/smsclient"

RDEPEND="${DEPEND}
	media-gfx/graphviz
	net-analyzer/nmap
	net-analyzer/fping"

need_php_cli

pkg_setup() {
	require_gd
	local DIE
	local flags="wddx sockets session spl"
	use mysql && flags="${flags} mysql"
	use postgres &&	flags="${flags} postgres"

	if ! PHPCHECKNODIE="yes" require_php_with_use ${flags} ; then
		DIE="yes"
	fi

	if [[ ${DIE} == "yes" ]] ; then
		eerror
		eerror "${PHP_PKG} needs to be re-installed with all of the following"
		eerror "USE flags enabled:"
		eerror
		eerror "${flags}"
		eerror
		die "Re-install ${PHP_PKG} with ${flags}"
	fi

	enewgroup jffnms
	enewuser jffnms -1 /bin/bash -1 jffnms,apache
}

src_install(){
	MY_DESTDIR="${D}opt/jffnms"

	dodir "${MY_DESTDIR}"
	cp -r * "${MY_DESTDIR}" || die
	chown -R jffnms:apache "${MY_DESTDIR}" || die
	chmod -R ug+rw "${MY_DESTDIR}" || die

	elog "JFFNMS has been partialy installed on your system. However you"
	elog "still need proceed with final installation and configuration."
	elog "You can visit http://www.gentoo.org/doc/en/jffnms.xml in order"
	elog "to get detailed information on how to get jffnms up and running."
}
