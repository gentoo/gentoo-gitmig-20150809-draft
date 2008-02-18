# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/bugport/bugport-1.146.ebuild,v 1.4 2008/02/18 11:23:48 hollow Exp $

inherit webapp depend.php

DESCRIPTION="Web-based system for managing tasks and defects throughout the software development process"
HOMEPAGE="http://www.incogen.com/index.php?type=General&param=bugport"
SRC_URI="http://www.incogen.com/downloads/${PN}/${PN}_${PV}.tar.gz"

LICENSE="BSD"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="dev-php/adodb"

need_php_httpd

S=${WORKDIR}/${PN}_${PV}

pkg_setup() {
	webapp_pkg_setup
	has_php
	require_php_with_use mysql
}

src_install() {
	webapp_src_preinst

	# fix INSTALL.txt to let the user know where the SQL scripts live
	sed -i -e "s|create_tables.sql|${MY_SQLSCRIPTSDIR}/mysql/${PV}_create.sql|" \
		INSTALL.txt || die "sed failed in INSTALL.txt"

	webapp_sqlscript mysql create_tables.sql
	rm -f *.sql

	dodoc *.txt
	docinto devel-docs
	dodoc devel-docs/*
	rm -rf *.txt devel-docs install-gentoo-unsupported

	# fix config file to know where to find adodb
	sed -i -e 's|^\(# \+\)\?\$adoDir.\+$|$adoDir = "/usr/lib/php/adodb/"; # DO NOT CHANGE!|' \
		conf/config.php || die "failed to fix adodb location in config.php."

	insinto ${MY_HTDOCSDIR}
	doins -r .

	webapp_configfile ${MY_HTDOCSDIR}/conf/config.php
	webapp_configfile ${MY_HTDOCSDIR}/conf/configuration.php

	webapp_postinst_txt en INSTALL.txt
	webapp_src_install
}
