# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/phpmyadmin/phpmyadmin-2.4.0.ebuild,v 1.4 2003/05/09 11:15:40 twp Exp $

inherit eutils

MY_PN=phpMyAdmin

S=${WORKDIR}/${MY_PN}-${PV}
DESCRIPTION="Web-based administration for MySQL database in php"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}-${PV}-php.tar.bz2"
HOMEPAGE="http://phpmyadmin.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
# only known to work on x86... can people test on other platforms?
KEYWORDS="x86 sparc ppc alpha"

DEPEND=">=net-www/apache-1.3.24-r1 >=dev-db/mysql-3.23.38 >=dev-php/mod_php-4.1.2-r5"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/phpmyadmin-config.patch
}

src_compile() {
	local pmapass="${RANDOM}${RANDOM}${RANDOM}${RANDOM}"
	mv config.inc.php config.inc.php.in
	sed -e "s/@pmapass@/${pmapass}/g" config.inc.php.in > config.inc.php
	sed -e "s/@pmapass@/${pmapass}/g" ${FILESDIR}/phpmyadmin-mysql-setup.sql.in > mysql-setup.sql
}

src_install () {

	# Attempt to guess DocumentRoot (bug # 20642)
	# 1. Use DOCUMENT_ROOT env var if set
	# 2. Grep apache.conf/apache2.conf as appropriate
	# 3. Fallback on /home/httpd/htdocs
	if [ -z "${DOCUMENT_ROOT}" ]; then
		if [ "`use apache2`" ]; then
			DOCUMENT_ROOT="`grep '^DocumentRoot' /etc/apache2/conf/apache2.conf | cut -d\  -f2`"
		else
			DOCUMENT_ROOT="`grep '^DocumentRoot' /etc/apache/conf/apache.conf | cut -d\  -f2`"
		fi
	fi
	einfo "DOCUMENT_ROOT=${DOCUMENT_ROOT}"
	[ -z "${DOCUMENT_ROOT}" ] && DOCUMENT_ROOT="/home/httpd/htdocs"

	insinto ${DOCUMENT_ROOT}/phpmyadmin
	doins *.{php,html} ChangeLog

	insinto ${DOCUMENT_ROOT}/phpmyadmin/images
	doins images/*.{gif,png}

	insinto ${DOCUMENT_ROOT}/phpmyadmin/scripts
	doins scripts/*.sh

	insinto ${DOCUMENT_ROOT}/phpmyadmin/lang
	doins lang/*.{php,sh}

	insinto ${DOCUMENT_ROOT}/phpmyadmin/libraries
	doins libraries/*.{php,js}

	insinto ${DOCUMENT_ROOT}/phpmyadmin/libraries/auth
	doins libraries/auth/*.php

	dodoc ANNOUNCE.txt CREDITS ChangeLog TODO Documentation.{txt,html} \
		INSTALL LICENSE RELEASE-DATE*

	insinto /etc/phpmyadmin
	doins config.inc.php mysql-setup.sql

	dosym /etc/phpmyadmin/config.inc.php ${DOCUMENT_ROOT}/phpmyadmin/config.inc.php
	
}

pkg_postinst() {
	einfo
	einfo "Run etc-update to update your configuration files if required, then run"
	einfo "  ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config"
	einfo "to setup MySQL for phpMyAdmin"
	einfo "Then point your browser to http://localhost/phpmyadmin/"
	einfo
}

pkg_config() {
	einfo "Type in your MySQL root password:"
	mysql -u root -p < ${ROOT}/etc/phpmyadmin/mysql-setup.sql || die
	einfo "You need to reload MySQL for the changes to take effect"
}
