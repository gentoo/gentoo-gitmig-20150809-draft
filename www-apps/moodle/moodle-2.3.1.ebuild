# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/moodle/moodle-2.3.1.ebuild,v 1.2 2012/07/11 23:00:12 blueness Exp $

EAPI="4"

inherit versionator webapp

AVC=( $(get_version_components) )
MY_BRANCH="stable${AVC[0]}${AVC[1]}"

DESCRIPTION="The Moodle Course Management System"
HOMEPAGE="http://moodle.org"
SRC_URI="http://download.moodle.org/${MY_BRANCH}/${P}.tgz"
S="${WORKDIR}/${PN}"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
#SLOT empty due to webapp

DB_FLAGS="mysqli?,postgres?"
DB_TYPES=${DB_FLAGS//\?/}
DB_TYPES=${DB_TYPES//,/ }

AUTHENTICATION_FLAGS="imap?,ldap?,odbc?"
AUTHENTICATION_MODES=${AUTHENTICATION_FLAGS//\?/}
AUTHENTICATION_MODES=${AUTHENTICATION_MODES//,/ }

PHP_REQUIRED_FLAGS_53="ctype,curl,iconv,json,session,simplexml,xml,zip"
PHP_OPTIONAL_FLAGS_53="gd,intl,soap,ssl,tokenizer,xmlrpc"
PHP_FLAGS_53="${PHP_REQUIRED_FLAGS_53},${PHP_OPTIONAL_FLAGS_53}"

IUSE="${DB_TYPES} ${AUTHENTICATION_MODES} vhosts"

# No forced dependency on
#  mysql? ( virtual/mysql )
#  postgres? ( dev-db/postgresql-server-7* )
# which may live on another server
DEPEND=""
RDEPEND="
	=dev-lang/php-5.3*[${DB_FLAGS},${AUTHENTICATION_FLAGS},${PHP_FLAGS_53}]
	virtual/httpd-php
	virtual/cron"

pkg_setup() {
	webapp_pkg_setup

	# How many dbs were selected? If one and only one, which one is it?
	MYDB=""
	DB_COUNT=0
	for db in ${DB_TYPES}; do
		if use ${db}; then
			MYDB=${db}
			DB_COUNT=$(($DB_COUNT+1))
		fi
	done

	if [[ ${DB_COUNT} -eq 0 ]]; then
		eerror
		eerror "\033[1;31m**************************************************\033[00m"
		eerror "No database selected in your USE flags,"
		eerror "You must select at least one."
		eerror "\033[1;31m**************************************************\033[00m"
		eerror
		die
	fi

	if [[ ${DB_COUNT} -gt 1 ]]; then
		MYDB=""
		ewarn
		ewarn "\033[1;33m**************************************************\033[00m"
		ewarn "Multiple databases selected in your USE flags,"
		ewarn "You will have to choose your database manually."
		ewarn "\033[1;33m**************************************************\033[00m"
		ewarn
	fi
}

src_prepare() {
	rm COPYING.txt
	cp "${FILESDIR}"/config.php .

	# Moodle expect postgres7, not postgres
	MYDB=${MYDB/postgres/postgres7}

	# Moodle expects mysql, not mysqli
	MYDB=${MYDB/mysqli/mysql}

	if [[ ${DB_COUNT} -eq 1 ]] ; then
		sed -i -e "s|mydb|${MYDB}|" config.php
	fi
}

src_install() {
	webapp_src_preinst

	local MOODLEDATA="${MY_HOSTROOTDIR}"/moodle
	dodir ${MOODLEDATA}
	webapp_serverowned -R "${MOODLEDATA}"

	local MOODLEROOT="${MY_HTDOCSDIR}"
	insinto ${MOODLEROOT}
	doins -r *

	webapp_configfile "${MOODLEROOT}"/config.php

	if [[ ${DB_COUNT} -eq 1 ]]; then
		webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	else
		webapp_postinst_txt en "${FILESDIR}"/postinstall-nodb-en.txt
	fi

	webapp_src_install
}

pkg_postinst() {
	einfo
	einfo "\033[1;32m**************************************************\033[00m"
	einfo
	einfo "To see the post install instructions, do"
	einfo
	einfo "    webapp-config --show-postinst ${PN} ${PVR}"
	einfo
	einfo "\033[1;32m**************************************************\033[00m"
	einfo
}
