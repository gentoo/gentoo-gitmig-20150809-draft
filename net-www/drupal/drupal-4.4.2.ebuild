# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/drupal/drupal-4.4.2.ebuild,v 1.2 2004/07/16 09:38:25 dholm Exp $

inherit webapp eutils

DESCRIPTION="Drupal is a PHP-based open-source platform and content management system for building dynamic web sites offering a broad range of features and services; including user administration, publishing workflow, discussion capabilities, news aggregation, metadata functionalities using controlled vocabularies and XML publishing for content sharing purposes. Equipped with a powerful blend of features and configurability, Drupal can support a diverse range of web projects ranging from personal weblogs to large community-driven sites."
HOMEPAGE="http://drupal.org"

SRC_URI="http://drupal.org/drupal/${P}.tgz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND="virtual/php"

src_compile() {
	#Default compile hangs!            
	echo "Nothing to compile"
}

src_install() {

	local docs="MAINTAINERS.txt LICENSE.txt INSTALL.txt CHANGELOG.txt"

	webapp_src_preinst

	# handle documentation files
	#
	# NOTE that doc files go into /usr/share/doc as normal; they do NOT
	# get installed per vhost!

	einfo "Installing docs"
	dodoc ${docs}
	for doc in ${docs} INSTALL; do
		rm -f ${doc}
	done

	einfo "Copying main files"
	cp -r . ${D}/${MY_HTDOCSDIR}
	#Not sure about this yet!
#	cp .htaccess ${D}/${HTTPD_ROOT}/drupal

	# Identify any script files that need #! headers adding to run under
	# a CGI script (such as PHP/CGI)
	#
	# for drupal, we *assume* that all .php files need to have CGI/BIN
	# support added

	for x in `find . -name '*.php' -print ` ; do
		webapp_runbycgibin php ${MY_HTDOCSDIR}/$x
	done

	#All files must be owned by server
	for x in `find . -type f -print` ; do
		webapp_serverowned ${MY_HTDOCSDIR}/$x
	done

	webapp_configfile ${MY_HTDOCSDIR}/includes/conf.php

	webapp_postinst_txt en ${FILESDIR}/${PV}/postinstall-en.txt

	webapp_src_install
}

