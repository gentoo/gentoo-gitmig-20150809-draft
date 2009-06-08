# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/postfixadmin/postfixadmin-2.1.0-r1.ebuild,v 1.4 2009/06/08 17:21:48 dertobi123 Exp $

inherit eutils webapp depend.php confutils

DESCRIPTION="Web Based Management tool for Postfix style virtual domains and users."
HOMEPAGE="http://high5.net/postfixadmin/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="MPL-1.1"
KEYWORDS="~amd64 ~x86"
IUSE="mysql postgres"

DEPEND=">=dev-lang/perl-5.0
	dev-perl/DBI
	mysql? ( dev-perl/DBD-mysql )
	postgres? ( dev-perl/DBD-Pg )"
RDEPEND="${DEPEND}"

need_httpd_cgi
need_php_httpd

pkg_setup() {
	webapp_pkg_setup

	confutils_require_any mysql postgres
	confutils_use_depend_built_with_all mysql mail-mta/postfix mysql
	confutils_use_depend_built_with_all postgres mail-mta/postfix postgres

	if use mysql; then
		enewgroup vacation
		enewuser vacation -1 -1 -1 vacation
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	ecvs_clean

	mv VIRTUAL_VACATION/INSTALL.TXT VIRTUAL_VACATION_INSTALL.TXT

	mv DATABASE_MYSQL.TXT "${T}"/mysql-setup.sql
	mv TABLE_CHANGES.TXT  "${T}"/mysql-update.sql
	mv DATABASE_PGSQL.TXT "${T}"/postgres-setup.sql

	mv config.inc.php{.sample,}
}

src_install() {
	webapp_src_preinst

	# virtual vacation only works with MySQL
	if use mysql; then
		diropts -m0770 -o vacation -g vacation
		dodir /var/spool/vacation
		keepdir /var/spool/vacation
		insinto /var/spool/vacation
		insopts -m770 -o vacation -g vacation
		doins "${S}"/VIRTUAL_VACATION/vacation.pl

	        diropts -m775 -o root -g root
	        insopts -m644 -o root -g root
	fi

	local docs="BACKUP_MX.TXT CHANGELOG.TXT INSTALL.TXT LANGUAGE.TXT
		TABLE_BACKUP_MX.TXT UPGRADE.TXT VIRTUAL_VACATION_INSTALL.TXT"
	dodoc ${docs}
	rm -rf ${docs} LICENSE.TXT ADDITIONS/

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	if use mysql; then
		webapp_sqlscript mysql "${T}"/mysql-setup.sql
		webapp_sqlscript mysql "${T}"/mysql-update.sql 2.0.x
		webapp_sqlscript mysql "${T}"/mysql-update.sql 1.5x
		webapp_postinst_txt en "${FILESDIR}"/postinstall-en-mysql.txt
	fi
	if use postgres; then
		webapp_sqlscript postgresql "${T}"/postgres-setup.sql
		webapp_postinst_txt en "${FILESDIR}"/postinstall-en-postgres.txt
	fi

	webapp_configfile "${MY_HTDOCSDIR}"/config.inc.php
	webapp_configfile "${MY_HTDOCSDIR}"/admin/.htpasswd

	webapp_hook_script "${FILESDIR}"/config-hook.sh

	webapp_src_install
}
