# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/bugport/bugport-1.146.ebuild,v 1.1 2004/11/26 23:05:37 pyrania Exp $

inherit webapp

DESCRIPTION="Web-based system for managing tasks and defects throughout the software development process"
HOMEPAGE="http://www.incogen.com/index.php?type=General&param=bugport"
SRC_URI="http://www.incogen.com/downloads/${PN}/${PN}_${PV}.tar.gz"

LICENSE="BSD"
KEYWORDS="~x86 ~ppc"

IUSE=""
RDEPEND=">=virtual/php-4.3
	dev-php/adodb"
DEPEND=""

S=${WORKDIR}/${PN}_${PV}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	# prepare ${D} for our arrival
	webapp_src_preinst

	# Fix INSTALL.txt to let the user know where the SQL scripts live
	sed -i \
	  -e "s|create_tables.sql|${MY_SQLSCRIPTSDIR}/mysql/${PV}_create.sql|" \
	  INSTALL.txt

	# Add the post-installation instructions
	webapp_postinst_txt en INSTALL.txt

	# Install documents
	dodoc *.txt
	rm *.txt
	docinto devel-docs
	dodoc devel-docs/*
	rm -rf devel-docs
	rm -rf install-gentoo-unsupported

	# Install SQL scripts
	#webapp_sqlscript mysql add_indices.sql
	#webapp_sqlscript mysql alter_user_table.sql
	#webapp_sqlscript mysql create_config_table.sql
	webapp_sqlscript mysql create_tables.sql

	# Fix config file to know where to find adodb
	sed -i \
	  -e 's|^\(# \+\)\?\$adoDir.\+$|$adoDir = "/usr/lib/php/adodb/"; # DO NOT CHANGE!|' \
	  conf/config.php

	# Install
	cp -R . ${D}${MY_HTDOCSDIR}

	# Identify the configuration files that this app uses
	webapp_configfile ${MY_HTDOCSDIR}/conf/config.php
	webapp_configfile ${MY_HTDOCSDIR}/conf/configuration.php

	# Let webapp.eclass do the rest
	webapp_src_install
}
