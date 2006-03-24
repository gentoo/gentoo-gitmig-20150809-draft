# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/knowledgetree/knowledgetree-3.0.1.ebuild,v 1.1 2006/03/24 06:47:50 wrobel Exp $

inherit webapp

MY_PN=${PN/tree/Tree}
MY_PV=${PV/_/}
MY_P=${MY_PN}-${MY_PV}

DESCRIPTION="KnowledgeTree is a document management system providing a content repository, workflow and routing of content, content publication and content metrics definition and analysis."
HOMEPAGE="http://www.ktdms.com/"
SRC_URI="mirror://sourceforge/kt-dms/${MY_P}.tgz"

LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/httpd-php
		dev-db/mysql
		app-text/catdoc
		>=app-text/pstotext-0.94.1
		"

S=${WORKDIR}/${MY_PN}

src_install() {
	webapp_src_preinst

	local docs="docs/CREDITS.txt
				docs/INSTALL.txt
				docs/README.txt
				docs/TODO.txt
				docs/UPGRADE.txt
				docs/FAQ.txt
				"

	dodoc ${docs}

	## Main application
	cp -r . ${D}${MY_HTDOCSDIR}

	## Docs installed, remove unnecessary files
	for doc in ${docs}
	do
	  rm ${D}${MY_HTDOCSDIR}/${doc}
	done

	for CFG in ${MY_HTDOCSDIR}/config/{config.ini,dmsDefaults.php,siteMap.inc,tableMappings.inc}
	do
	  webapp_configfile ${CFG}
	done

	## Documents will be saved here
	webapp_serverowned ${MY_HTDOCSDIR}/var/log
	webapp_serverowned ${MY_HTDOCSDIR}/var/tmp
	webapp_serverowned ${MY_HTDOCSDIR}/var/Documents
	webapp_serverowned "${MY_HTDOCSDIR}/var/Documents/Root Folder"
	webapp_serverowned "${MY_HTDOCSDIR}/var/Documents/Root Folder/Default Unit"

	webapp_sqlscript mysql    sql/mysql/install/structure.sql
	webapp_sqlscript mysql    sql/mysql/install/data.sql
	webapp_sqlscript postgres sql/pgsql/install/tables.sql
	webapp_sqlscript postgres sql/pgsql/install/functions.sql

	webapp_postinst_txt en ${FILESDIR}/postinstall-en-${PV}.txt
	webapp_postupgrade_txt en ${FILESDIR}/postupgrade-en-${PV}.txt

	## Fix for the root folder
	webapp_hook_script ${FILESDIR}/config-hook-${PV}.sh

	webapp_src_install
}
