# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/egroupware/egroupware-1.2.ebuild,v 1.1 2006/04/22 15:29:41 rl03 Exp $

inherit webapp depend.php

MY_PN=eGroupWare
S=${WORKDIR}/${PN}

DESCRIPTION="Web-based GroupWare suite"
HOMEPAGE="http://www.eGroupWare.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}-${PV}-1.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="gd jpgraph ldap mysql postgres"

RDEPEND="
	mysql? ( >=dev-db/mysql-4 )
	postgres? ( >=dev-db/postgresql-7.2 )
	ldap? ( net-nds/openldap )
	gd? ( media-libs/gd )
	jpgraph? ( || ( dev-php4/jpgraph dev-php5/jpgraph ) )
	dev-php/PEAR-Log
	net-www/apache"

pkg_setup () {
	has_php
	webapp_pkg_setup

	require_php_with_use imap session
	use ldap && require_php_with_use ldap
	use mysql && require_php_with_use mysql
	use postgres && require_php_with_use postgres
	einfo "Consider installing an MTA if you want to use eGW's mail capabilities."
}

src_unpack() {
	has_php

	unpack ${A}
	cd ${S}
	# remove CVS directories
	find . -type d -name 'CVS' -print | xargs rm -rf

	if use jpgraph; then
		einfo "Fixing jpgraph location"
		sed -i "s|EGW_SERVER_ROOT . '/../jpgraph/src/jpgraph.php'|'/usr/share/php${PHP_VERSION}/jpgraph/jpgraph.php'|" projectmanager/inc/class.ganttchart.inc.php || die
		sed -i "s|EGW_SERVER_ROOT . '/../jpgraph/src/jpgraph_gantt.php'|'/usr/share/php${PHP_VERSION}/jpgraph/jpgraph_gantt.php'|" projectmanager/inc/class.ganttchart.inc.php || die
	fi
}

src_install() {
	webapp_src_preinst
	cp -r . ${D}/${MY_HTDOCSDIR}

	webapp_serverowned ${MY_HTDOCSDIR}/phpgwapi/images

	webapp_postinst_txt en ${FILESDIR}/postinstall-en-${PV}.txt
	webapp_src_install
}
