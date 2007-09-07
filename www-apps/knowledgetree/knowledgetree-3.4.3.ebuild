# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/knowledgetree/knowledgetree-3.4.3.ebuild,v 1.1 2007/09/07 14:04:30 wrobel Exp $

inherit webapp depend.php

MY_PN=ktdms-src-oss
MY_PV=${PV/_/}
MY_P=${MY_PN}-${MY_PV}

DESCRIPTION="KnowledgeTree is a document management system providing a content repository, workflow and routing of content, content publication and content metrics definition and analysis."
HOMEPAGE="http://www.ktdms.com/"
SRC_URI="mirror://sourceforge/kt-dms/${MY_P}.tgz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE="office opendoc pdf ps"

DEPEND="office? ( >=app-text/catdoc-0.94.1 )
	ps? ( app-text/pstotext )
	pdf? ( app-text/poppler )
	opendoc? ( app-arch/unzip )"

need_php4_httpd

S=${WORKDIR}/knowledgeTree-OSS

src_install() {
	webapp_src_preinst

	# Local docs have been dropped in favour of online docs
	local docs="docs/README.txt"

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

	keepdir ${MY_HTDOCSDIR}/var/cache

	## Documents will be saved here
	webapp_serverowned ${MY_HTDOCSDIR}/var/cache
	webapp_serverowned ${MY_HTDOCSDIR}/var/log
	webapp_serverowned ${MY_HTDOCSDIR}/var/tmp
	webapp_serverowned ${MY_HTDOCSDIR}/var/Documents
	#webapp_serverowned "${MY_HTDOCSDIR}/var/Documents/Root Folder"
	#webapp_serverowned "${MY_HTDOCSDIR}/var/Documents/Root Folder/Default Unit"

	webapp_sqlscript mysql    sql/mysql/install/structure.sql
	webapp_sqlscript mysql    sql/mysql/install/data.sql
# We don't currently support postgres anymore. Coming soon.
#	webapp_sqlscript postgres sql/pgsql/install/tables.sql
#	webapp_sqlscript postgres sql/pgsql/install/functions.sql

	webapp_postinst_txt en ${FILESDIR}/postinstall-en-${PV}.txt
	webapp_postupgrade_txt en ${FILESDIR}/postupgrade-en-${PV}.txt

	## Fix for the root folder
	webapp_hook_script ${FILESDIR}/config-hook-${PV}.sh

	webapp_src_install
}
