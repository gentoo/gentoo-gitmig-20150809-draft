# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# /space/gentoo/cvsroot/gentoo-x86

DEPEND="dev-lang/perl
	dev-perl/Net-Pcap
	dev-perl/NetPacket
	dev-perl/Unicode-String
	dev-perl/FileHandle-Rollback
	dev-perl/Proc-Daemon
	mysql? ( dev-perl/DBI
		dev-db/mysql )
	samba? ( net-fs/samba )"
DESCRIPTION="AIM Sniff is a utility for monitoring and archiving AOL Instant Messenger messages across a network."
HOMEPAGE="http://www.aimsniff.com"
IUSE="samba mysql apache2"
KEYWORDS="~x86"
LICENSE="GPL-2"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	 mirror://sourceforge/${PN}/was_0.1.1b.tar.gz" 

src_install() {
	use apache2 || HTTPD_ROOT="`grep '^DocumentRoot' /etc/apache/conf/apache.conf | cut -d\  -f2`" \
		HTTPD_USER="`grep '^User' /etc/apache/conf/commonapache.conf | cut -d \  -f2`" \
		HTTPD_GROUP="`grep '^Group' /etc/apache/conf/commonapache.conf | cut -d \  -f2`" 
	use apache2 && HTTPD_ROOT="`grep '^DocumentRoot' /etc/apache2/conf/apache2.conf | cut -d\  -f2`" \
		HTTPD_USER="`grep '^User' /etc/apache2/conf/commonapache2.conf | cut -d \  -f2`" \
		HTTPD_GROUP="`grep '^Group' /etc/apache2/conf/commonapache2.conf | cut -d \  -f2`" 

	[ -z "${HTTPD_ROOT}" ] && HTTPD_ROOT="/home/httpd/htdocs"
	[ -z "${HTTPD_USER}" ] && HTTPD_USER="apache"
	[ -z "${HTTPD_GROUP}" ] && HTTPD_GROUP="apache"

	dodir /etc/${PN}
	cp aimSniff.pl aimsniff 
	dosbin aimsniff
	cp aimsniff.config table.struct ${D}etc/${PN}
	dodoc README ChangeLog
	#Installing Web-Frontend
	dodir ${HTTPD_ROOT}
	mv ../was ${D}${HTTPD_ROOT} \
		&& cd ${D}${HTTPD_ROOT} \
		&& chown -R ${HTTPD_USER}.${HTTPD_GROUP} *|| ewarn "check web-frontend in ${HTTPD_ROOT}" 
}
pkg_postinst() {
	einfo "Go to http://${HOSTNAME}/was/ to check if everything works."
	use mysql && einfo "If you plan to use the database dump feature, you'll have to load the table.struct file into mysql." \
		&& einfo "To do this run the following command 'mysql < /etc/${PN}/table.struct'." \
		&& einfo "This will create a database named 'aim' with all the right tables." \
		&& einfo "After that use: 'GRANT ALL ON aim.* TO username@hostname IDENTIFIED BY 'password';'" \
		&& einfo "and go to http://${HOSTNAME}/was/admin.php to fill in the blanks."
	use samba && einfo "--SMB <-Turn SMB lookups 'on' to get NT domain usernames with AIM logins, Off by default."
}

