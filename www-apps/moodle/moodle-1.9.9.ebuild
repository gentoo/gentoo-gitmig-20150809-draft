# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/moodle/moodle-1.9.9.ebuild,v 1.2 2010/07/19 15:42:16 mr_bones_ Exp $

EAPI="2"

inherit versionator webapp depend.php

AVC=( $(get_version_components) )
MY_BRANCH="stable${AVC[0]}${AVC[1]}"
DBTYPES="mysql postgres"
AUTHMODES="imap ldap odbc radius"
PHPFLAGS="${DBTYPES} ${AUTHMODES}"

DESCRIPTION="The Moodle Course Management System"
HOMEPAGE="http://moodle.org"
SRC_URI="http://download.moodle.org/${MY_BRANCH}/${P}.tgz"
S="${WORKDIR}/${PN}"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
#SLOT empty due to webapp
IUSE="${PHPFLAGS} vhosts"

# No forced dependency on
#  mysql? ( virtual/mysql )
#  postgres? ( dev-db/postgresql-server-7* )
# which may live on another server
DEPEND=""
RDEPEND="virtual/cron"

need_php5_httpd

pkg_setup() {
	webapp_pkg_setup

	# How many dbs were selected? If one and only one, which one is it?
	MYDB=""
	DBCOUNT=0
	for db in ${DBTYPES}; do
		if use ${db}; then
			MYDB=${db}
			DBCOUNT=$(($DBCOUNT+1))
		fi
	done

	if [[ ${DBCOUNT} -ne 1 ]]; then
		MYDB=""
		ewarn
		ewarn "\033[1;33m**************************************************\033[1;33m"
		ewarn "No db, or multiple dbs, selected in your USE flags,"
		ewarn "You will have to choose your database manually."
		ewarn "\033[1;33m**************************************************\033[1;33m"
		ewarn
	fi

	local flags="ctype curl gd iconv ssl tokenizer xml xmlrpc zlib"

	for flg in ${PHPFLAGS}; do
		if use ${flg}; then
			flags="${flags} ${flg}"
		fi
	done

	if ! PHPCHECKNODIE="yes" require_php_with_use ${flags} ; then
		eerror
		eerror "\033[1;31m************************************************************\033[1;31m"
		eerror "Re-install ${PHP_PKG} with the following flags:"
		eerror "    ${flags}"
		eerror "\033[1;31m************************************************************\033[1;31m"
		eerror
		die
	fi
}

src_prepare() {
	rm COPYING.txt
	cp "${FILESDIR}"/config.php .

	#
	# Moodle expect postgres7, not postgres
	#
	MYDB=${MYDB/postgres/postgres7}
	if [[ ${DBCOUNT} -eq 1 ]] ; then
		sed -i -e "s|mydb|${MYDB}|" config.php
	fi
}

src_install() {
	webapp_src_preinst

	local MOODLEDATA="${MY_HOSTROOTDIR}"/moodle
	dodir ${MOODLEDATA}
	webapp_serverowned -R "${MOODLEDATA}"

	local MOODLEROOT="${MY_HTDOCSDIR}"
	insinto ${MOODLEROOT} || die "Unable to insinto ${MOODLEROOT}"
	doins -r *

	webapp_configfile "${MOODLEROOT}"/config.php

	if [[ ${DBCOUNT} -eq 1 ]]; then
		webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	else
		webapp_postinst_txt en "${FILESDIR}"/postinstall-nodb-en.txt
	fi

	webapp_src_install
}

pkg_postinst() {
	einfo
	einfo "\033[1;32m**************************************************\033[1;32m"
	einfo
	einfo "To see the post install instructions, do"
	einfo
	einfo "    webapp-config --show-postinst ${PN} ${PV}"
	einfo
	einfo "\033[1;32m**************************************************\033[1;32m"
	einfo
}
