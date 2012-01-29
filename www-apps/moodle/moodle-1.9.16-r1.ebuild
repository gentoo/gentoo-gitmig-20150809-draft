# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/moodle/moodle-1.9.16-r1.ebuild,v 1.1 2012/01/29 03:09:40 blueness Exp $

EAPI="4"

inherit versionator webapp

AVC=( $(get_version_components) )
MY_BRANCH="stable${AVC[0]}${AVC[1]}"

DESCRIPTION="The Moodle Course Management System"
HOMEPAGE="http://moodle.org"
SRC_URI="http://download.moodle.org/${MY_BRANCH}/${P}.tgz"
S="${WORKDIR}/${PN}"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
#SLOT empty due to webapp

DBFLAGS="mysql?,postgres?"
DBTYPES=${DBFLAGS//\?/}
DBTYPES=${DBTYPES//,/ }

AUTHFLAGS="imap?,ldap?,odbc?"
AUTHMODES=${AUTHFLAGS//\?/}
AUTHMODES=${AUTHMODES//,/ }

PHPFLAGS="ctype,curl,gd,iconv,session,ssl,tokenizer,xml,xmlrpc,zlib"

IUSE="${DBTYPES} ${AUTHMODES} vhosts"

# No forced dependency on
#  mysql? ( virtual/mysql )
#  postgres? ( dev-db/postgresql-server-7* )
# which may live on another server
DEPEND=""
RDEPEND="
	>=dev-lang/php-4.3.0[${DBFLAGS},${AUTHFLAGS},${PHPFLAGS}]
	virtual/httpd-php
	virtual/cron"

pkg_setup() {
	webapp_pkg_setup

	# How many dbs were selected? If one and only one, which one is it?
	MYDB=""
	DB_COUNT=0
	for db in ${DBTYPES}; do
		if use ${db}; then
			MYDB=${db}
			DB_COUNT=$(($DB_COUNT+1))
		fi
	done

	if [[ ${DB_COUNT} -eq 0 ]]; then
		eerror
		eerror "\033[1;31m**************************************************\033[1;31m"
		eerror "No database selected in your USE flags,"
		eerror "You must select at least one."
		eerror "\033[1;31m**************************************************\033[1;31m"
		eerror
		die
	fi

	if [[ ${DB_COUNT} -gt 1 ]]; then
		MYDB=""
		ewarn
		ewarn "\033[1;33m**************************************************\033[1;33m"
		ewarn "Multiple databases selected in your USE flags,"
		ewarn "You will have to choose your database manually."
		ewarn "\033[1;33m**************************************************\033[1;33m"
		ewarn
	fi
}

src_prepare() {
	rm COPYING.txt
	cp "${FILESDIR}"/config.php .

	#
	# Moodle expect postgres7, not postgres
	#
	MYDB=${MYDB/postgres/postgres7}
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
	einfo "\033[1;32m**************************************************\033[1;32m"
	einfo
	einfo "To see the post install instructions, do"
	einfo
	einfo "    webapp-config --show-postinst ${PN} ${PVR}"
	einfo
	einfo "\033[1;32m**************************************************\033[1;32m"
	einfo
}
