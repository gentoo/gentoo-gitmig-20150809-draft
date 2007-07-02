# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/postfixadmin/postfixadmin-2.1.0.ebuild,v 1.7 2007/07/02 14:38:00 peper Exp $

# Source: http://bugs.gentoo.org/show_bug.cgi?id=50035
# Submitted-By: SteveB <tp22a@softhome.net>
# Reviewed-By: wrobel 2005-12-14
# $Id: postfixadmin-2.1.0.ebuild,v 1.7 2007/07/02 14:38:00 peper Exp $

inherit eutils webapp

IUSE="vhosts"
DESCRIPTION="Postfix Admin is a Web Based Management tool for Postfix when you are dealing with Postfix Style Virtual Domains and Virtual Users that are stored in MySQL."
HOMEPAGE="http://high5.net/postfixadmin/"
SRC_URI="http://high5.net/page7_files/${PN}-${PV}.tgz"
RESTRICT="mirror"
KEYWORDS="~amd64 ~x86"

DEPEND="virtual/httpd-php
		>=mail-mta/postfix-2.0.0
		>=net-www/apache-2.0
		>=dev-lang/perl-5.0
		dev-perl/DBI
		dev-perl/DBD-mysql"

RDEPEND=">=sys-apps/sed-4.0.5
		sys-apps/grep
		sys-apps/findutils"

LICENSE="MPL-1.1"

pkg_setup() {
	webapp_pkg_setup
	id vacation 2>/dev/null || enewgroup vacation
	id vacation 2>/dev/null || enewuser vacation -1 -1 /dev/null vacation
}

src_unpack() {
	unpack ${A} || die
	cd ${S}

	# Remove .cvs* files and CVS directories
	find ${S} -name .cvs\* -or \( -type d -name CVS -prune \) -exec rm -rf {} \;

	# Database support (we don't care wich one is used. Allow both of them!)
	cp ./DATABASE_MYSQL.TXT ${T}/mysql-setup.sql || die "Creating MySQL setup script failed!"
	cp ./TABLE_CHANGES.TXT ${T}/mysql-update.sql || die "Creating MySQL update script failed!"
	cp ./VIRTUAL_VACATION/INSTALL.TXT ${T}/VIRTUAL_VACATION_INSTALL.TXT

	# Rename config.inc.php
	cp ./config.inc.php.sample ${T}/config.inc.php || die "Creating config file failed!"

}

src_install() {
	webapp_src_preinst


	# Virtual Vacation only works with MySQL
	diropts -m0770 -o vacation -g vacation
	dodir /var/spool/vacation
	keepdir /var/spool/vacation
	insinto /var/spool/vacation
	insopts -m770 -o vacation -g vacation
	doins ${S}/VIRTUAL_VACATION/vacation.pl

	# Documentation
	#
	local docs="BACKUP_MX.TXT CHANGELOG.TXT INSTALL.TXT LANGUAGE.TXT LICENSE.TXT TABLE_BACKUP_MX.TXT TABLE_CHANGES.TXT UPGRADE.TXT"
	docs="${docs} DATABASE_MYSQL.TXT ${T}/VIRTUAL_VACATION_INSTALL.TXT"

	# install the SQL scripts available to us
	#
	# unfortunately, we do not have scripts to upgrade from older versions
	# these are things we need to add at a later date
	#
	webapp_sqlscript mysql ${T}/mysql-setup.sql
	webapp_sqlscript mysql ${T}/mysql-update.sql 2.0.x
	webapp_sqlscript mysql ${T}/mysql-update.sql 1.5x


	# Copy the app's main files
	#
	einfo "Installing main files"
	mkdir -p ${D}${MY_HTDOCSDIR}
	cp -r . ${D}${MY_HTDOCSDIR} || die "cp failed"
	cp ${T}/config.inc.php ${D}${MY_HTDOCSDIR} || die "cp failed"

	# handle documentation files
	#
	# NOTE that doc files go into /usr/share/doc as normal; they do NOT
	# get installed per vhost!
	#
	dodoc ${docs}
	for foo in ${docs} DATABASE_MYSQL.TXT DATABASE_PGSQL.TXT ADDITIONS VIRTUAL_VACATION
	do
		rm -f ${D}${MY_HTDOCSDIR}/${foo}
	done

	# Identify the configuration files that this app uses
	#
	webapp_configfile ${MY_HTDOCSDIR}/config.inc.php
	webapp_configfile ${MY_HTDOCSDIR}/admin/.htpasswd

	# Add the hook file to fix the .htaccess file
	webapp_hook_script ${FILESDIR}/config-hook.sh

	# Add the post-installation instructions
	#
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	# All done
	#
	# Now we let the eclass strut its stuff ;-)
	#
	webapp_src_install
}
