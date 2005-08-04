# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/drupal/drupal-4.6.2.ebuild,v 1.6 2005/08/04 09:08:24 st_lim Exp $

inherit webapp eutils

MY_PV=${PV:0:3}.0

DESCRIPTION="Drupal is a PHP-based open-source platform and content management system for building dynamic web sites offering a broad range of features and services; including user administration, publishing workflow, discussion capabilities, news aggregation, metadata functionalities using controlled vocabularies and XML publishing for content sharing purposes. Equipped with a powerful blend of features and configurability, Drupal can support a diverse range of web projects ranging from personal weblogs to large community-driven sites."
HOMEPAGE="http://drupal.org"
IUSE="mysql"

SRC_URI="http://drupal.org/files/projects/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~alpha ~ppc ~x86 ~amd64"

DEPEND="virtual/php"
RDEPEND="mysql? (dev-db/mysql)"

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

	# we install the .htaccess file to enable support for clean URLs
	cp .htaccess ${D}/${MY_HTDOCSDIR}

	# create the files upload directory
	mkdir ${D}/${MY_HTDOCSDIR}/files
	webapp_serverowned ${MY_HTDOCSDIR}/files

	#All files must be owned by server
	for x in `find . -type f -print` ; do
		webapp_serverowned ${MY_HTDOCSDIR}/$x
	done

	webapp_configfile ${MY_HTDOCSDIR}/sites/default/settings.php

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}

pkg_postinst() {
	webapp_pkg_postinst
	einfo
	einfo "You might want to run:"
	einfo "\"ebuild /var/db/pkg/www-apps/${PF}/${PF}.ebuild config\""
	einfo "if this is a new install."
	einfo
}

pkg_config() {
	# This is the default directory, but we have this portion for the user to
	# change the default directory if it does not exist.
	MY_HTDOCSDIR=/usr/share/webapps/${PN}/${PV}/htdocs
	if [ ! -d ${MY_HTDOCSDIR} ] && \
		[ ! -d ${MY_HTDOCSDIR}/modules ] && \
		[ ! -d ${MY_HTDOCSDIR}/themes ] && \
		[ ! -d ${MY_HTDOCSDIR}/themes/engines ] && \
		[ ! -d ${MY_HTDOCSDIR}/language ] ; then
		einfo "Please specify the directory your drupal installation "
		einfo "is installed in."
		echo
		while true
		do
			read -p " Please type in the name of the directory: " MY_HTDOCSDIR
			[ -d ${MY_HTDOCSDIR} ] && \
				[ -d ${MY_HTDOCSDIR}/modules ] && \
				[ -d ${MY_HTDOCSDIR}/themes ] && \
				[ -d ${MY_HTDOCSDIR}/themes/engines ] && \
				[ -d ${MY_HTDOCSDIR}/language ] && \
				break || \
				ewarn "The directory ${MY_HTDOCSDIR} does not exist"
		done
	fi
	if [ -d ${MY_HTDOCSDIR} ] && \
		[ -d ${MY_HTDOCSDIR}/modules ] && \
		[ -d ${MY_HTDOCSDIR}/themes ] && \
		[ -d ${MY_HTDOCSDIR}/themes/engines ] && \
		[ -d ${MY_HTDOCSDIR}/language ] ; then
		for i in modules themes engines language; do
			cd ${MY_HTDOCSDIR}/$i
			[ "$i" == "engines" ] && cd ${S}/themes/$i
			[ "$i" == "language" ] && cd ${S}/includes
			for item in `cat ${PORTDIR}/www-apps/${PN}/files/${MY_PV}/$i`; do
				einfo "Unpacking $item"
				wget -q http://www.drupal.org/files/projects/$item-${MY_PV}.tar.gz
				tar xfz $item-${MY_PV}.tar.gz
			done
		done

		find ${MY_HTDOCSDIR} -name "*.tar.gz" -exec rm -rf {} \;
		find ${MY_HTDOCSDIR} -type f -exec chmod 644 {} \;
		find ${MY_HTDOCSDIR} -type d -exec chmod 755 {} \;
	fi
}
