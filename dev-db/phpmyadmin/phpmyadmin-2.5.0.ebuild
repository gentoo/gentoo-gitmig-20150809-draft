# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/phpmyadmin/phpmyadmin-2.5.0.ebuild,v 1.1 2003/05/12 22:16:49 twp Exp $

inherit eutils

MY_P=phpMyAdmin-${PV}
DESCRIPTION="Web-based administration for MySQL database in PHP"
HOMEPAGE="http://phpmyadmin.sourceforge.net/"
SRC_URI="mirror://sourceforge/phpmyadmin/${MY_P}-php.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~arm ~hppa ~mips ~sparc ~x86"
DEPEND=">=net-www/apache-1.3
	>=dev-db/mysql-3.21 <dev-db/mysql-4.1
	>=dev-php/mod_php-3.0.8
	sys-apps/findutils"
S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/config.inc.php-${PV}.patch
}

src_compile() {
	local pmapass="${RANDOM}${RANDOM}${RANDOM}${RANDOM}"
	mv config.inc.php config.inc.php.orig
	sed -e "s/@pmapass@/${pmapass}/g" \
		config.inc.php.orig > config.inc.php
	sed -e "s/@pmapass@/${pmapass}/g" \
		${FILESDIR}/mysql-setup.sql.in-${PV} > mysql-setup.sql
}

src_install() {

	local DocumentRoot=/home/httpd/htdocs
	local destdir=${DocumentRoot}/phpmyadmin
	local docs="ANNOUNCE.txt CREDITS Documentation.txt README RELEASE-DATE-${PV} TODO"

	# Copy everything
	mkdir -p ${D}${destdir}
	cp -r . ${D}${destdir}
	# Remove documentation files
	for doc in ${docs} INSTALL LICENSE; do
		rm -f ${D}${destdir}/${doc}
	done
	# Remove .cvs* files and CVS directories
	find ${D}${destdir} -name .cvs\* -or \( -type d -name CVS -prune \) | xargs rm -rf
	# Fix permissions
	find ${D}${destdir} -type d | xargs chmod 755
	find ${D}${destdir} -type f | xargs chmod 644

	dodoc ${docs} ChangeLog

	insinto /etc/phpmyadmin
	doins config.inc.php mysql-setup.sql
	dosym /etc/phpmyadmin/config.inc.php ${destdir}/config.inc.php
	
}

pkg_postinst() {
	einfo
	einfo "To complete installation, you must"
	einfo "1. Update your configuration files:"
	einfo "     etc-update"
	einfo "2. Update MySQL's grant tables and the pmadb database:"
	einfo "     ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config"
	einfo "3. Reload MySQL:"
	einfo "     /etc/init.d/mysql restart"
	einfo
	einfo "If you are upgrading from an earlier version and are using phpMyAdmin's"
	einfo "features for master/foreign tables be sure to read"
	einfo "  http://localhost/phpmyadmin/Documentation.html#col_com"
	einfo "You will need to perform the ALTER TABLE step yourself."
	einfo
	einfo "Finally, point your browser to http://localhost/phpmyadmin/."
	einfo
}

pkg_config() {
	einfo "Type in your MySQL root password:"
	mysql -u root -p < ${ROOT}/etc/phpmyadmin/mysql-setup.sql || die
	einfo "You need to reload MySQL for the changes to take effect"
}
