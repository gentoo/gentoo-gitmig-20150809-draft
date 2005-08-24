# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/phpgnucacheii/phpgnucacheii-2.1.1.ebuild,v 1.4 2005/08/24 15:03:11 sekretarz Exp $

inherit webapp

DESCRIPTION="web-based distributed host caching system for the gnutella network"
HOMEPAGE="http://gwcii.sourceforge.net/"
SRC_URI="mirror://sourceforge/gwcii/${P}.tar.gz"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="x86 ~ppc"

S=${WORKDIR}/${PN}

RDEPEND=">=net-www/apache-1.3.24-r1
	>=dev-php/mod_php-4.3
	>=dev-db/mysql-4"

pkg_preinst() {
	webapp_src_preinst
	ewarn "Only install this package if you know what you're doing!"
	ewarn "YOU HAVE BEEN WARNED: while using this package benefits the"
	ewarn "gnutella network, it will cause many gnutella users to"
	ewarn "connect to your web server, requiring many system resources."
}

src_install() {
	webapp_src_preinst
	cp -pPR gwcii.php expert.phpgnucacheii.schema phpgnucacheii.schema config "${D}/${MY_HTDOCSDIR}"
	cp ${FILESDIR}/confightaccess ${D}/${MY_HTDOCSDIR}/config/.htaccess
	webapp_configfile ${MY_HTDOCSDIR}/config/.htaccess
	dodoc README CHANGELOG
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_src_install
}

pkg_postinst() {
	webapp_pkg_postinst
	einfo "To set up the mysql tables for this package, please run:"
	einfo "\tebuild /var/db/pkg/net-p2p/${P}/${P}.ebuild config"
}

pkg_config() {
	echo
	einfo "Creating database for your cache..."
	echo -n "Please enter your mysql root password (will be displayed): "
	read mysql_root
	einfo "Creating the \"gcache\" database..."
	/usr/bin/mysqladmin -p$mysql_root -u root create gcache
	/usr/bin/mysql -p$mysql_root -u root gcache < ${FILESDIR}/expert.phpgnucacheii.schema
	echo -n "Please enter your username that you want to connect to the database with: "
	read user
	echo -n "Please enter the password that you want to use for your database: "
	read password
	einfo "Granting permisions on database using 'GRANT ALL ON gcache.* TO $user IDENTIFIED BY '$password';'"
	echo "GRANT ALL ON gcache.* TO $user@localhost IDENTIFIED BY '$password';" | /usr/bin/mysql -p$mysql_root -u root gcache
	ewarn "You must now edit the config/config.inc file to connect to the database."
}
