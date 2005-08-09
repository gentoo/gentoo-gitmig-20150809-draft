# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/knowledgetree/knowledgetree-2.0.7.ebuild,v 1.1 2005/08/09 11:35:05 rl03 Exp $

inherit eutils webapp

MY_PN=${PN/tree/Tree}
MY_P=${MY_PN}-${PV}
DESCRIPTION="KnowledgeTree is a document management system providing a content repository, workflow and routing of content, content publication and content metrics definition and analysis."
HOMEPAGE="http://www.ktdms.com/"
SRC_URI="mirror://sourceforge/kt-dms/${MY_P}.tgz"

LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND="
		virtual/php
		dev-db/mysql
		>=PEAR-DB-1.6.4
		>=PEAR-Log-1.8.3
		"
S=${WORKDIR}/${MY_PN}

src_unpack() {

	unpack ${A} && cd "${S}"

	## The ebuild depends on PEAR-DB and PEAR-Log.
	## No need for additional PEAR library files
	rm -rf thirdparty

	## not running any tests
	rm -rf tests

	## Example apache, php and mysql config files
	cd etc
	for FL in *
	  do
	  mv ${FL} example-${FL}
	done
}

src_install() {
	webapp_src_preinst

	local docs="docs/CREDITS.txt
				docs/ChangeLog.txt
				docs/INSTALL.txt
				docs/README.txt
				docs/TODO.txt
				docs/UPGRADE.txt
				docs/faq.txt
				docs/i18n.txt
				docs/SearchPermissions.txt
				sql/mysql/install/user.sql
				"

	dodoc ${docs} etc/*

	## Main application
	cp -r . ${D}${MY_HTDOCSDIR}

	## Docs installed, remove unnecessary files
	rm -rf ${D}${MY_HTDOCSDIR}/etc
	for doc in ${docs}
	do
	  rm ${D}${MY_HTDOCSDIR}/${doc}
	done

	for CFG in ${MY_HTDOCSDIR}/config/{browsers.inc,dmsDefaults.php,environment.php,siteMap.inc,tableMappings.inc}
	do
	  webapp_configfile ${CFG}
	done

	## Documents will be saved here
	webapp_serverowned ${MY_HTDOCSDIR}/log
	webapp_serverowned ${MY_HTDOCSDIR}/Documents
	webapp_serverowned ${MY_HTDOCSDIR}/Documents/Root\ Folder
	webapp_serverowned ${MY_HTDOCSDIR}/Documents/Root\ Folder/Default\ Unit

	webapp_postinst_txt en ${FILESDIR}/postinstall-en-2.0.7.txt

	## Fix for the root folder
	webapp_hook_script ${FILESDIR}/config-hook-2.0.0.sh

	webapp_src_install
}
