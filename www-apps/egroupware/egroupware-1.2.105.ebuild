# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/egroupware/egroupware-1.2.105.ebuild,v 1.3 2007/01/02 22:24:32 rl03 Exp $

inherit webapp depend.php

MY_PN=eGroupWare
MY_PV=${PV/.105/-105}
S=${WORKDIR}/${PN}

DESCRIPTION="Web-based GroupWare suite"
HOMEPAGE="http://www.eGroupWare.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}-${MY_PV}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="gd jpgraph ldap mysql postgres"

RDEPEND="
	ldap? ( net-nds/openldap )
	gd? ( media-libs/gd )
	jpgraph? ( || ( dev-php4/jpgraph dev-php5/jpgraph ) )
	dev-php/PEAR-Log
	net-www/apache"

pkg_setup () {
	has_php
	webapp_pkg_setup

	local php_flags="imap session"

	use ldap && php_flags="${php_flags} ldap"
	use mysql && php_flags="${php_flags} mysql"
	use postgres && php_flags="${php_flags} postgres"
	require_php_with_use ${php_flags}

	elog "Consider installing an MTA if you want to use eGW's mail capabilities."
}

src_unpack() {
	has_php

	unpack ${A}
	cd ${S}
	# remove SVN directories
	find . -type d -name '.svn' -print | xargs rm -rf

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

	webapp_postinst_txt en ${FILESDIR}/postinstall-en-1.2.txt
	webapp_src_install
}
