# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/aimsniff/aimsniff-0.8.ebuild,v 1.3 2003/09/05 23:40:08 msterret Exp $

inherit webapp-apache

DESCRIPTION="utility for monitoring and archiving AOL Instant Messenger messages across a network"
HOMEPAGE="http://www.aimsniff.com/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	 mirror://sourceforge/${PN}/was_0.1.1b.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="samba mysql apache2"

DEPEND="dev-lang/perl
	dev-perl/Net-Pcap
	dev-perl/NetPacket
	dev-perl/Unicode-String
	dev-perl/FileHandle-Rollback
	dev-perl/Proc-Daemon
	mysql? ( dev-perl/DBI dev-db/mysql )
	samba? ( net-fs/samba )"

src_install() {
	newsbin aimsniff.pl aimsniff
	insinto /etc/${PN}
	doins aimsniff.config table.struct
	dodoc README ChangeLog

	webapp-detect
	dodir ${HTTPD_ROOT}
	mv ../was ${D}/${HTTPD_ROOT}
	cd ${D}/${HTTPD_ROOT}
	chown -R ${HTTPD_USER}.${HTTPD_GROUP} *
}

pkg_postinst() {
	einfo "Go to http://${HOSTNAME}/was/ to check if everything works."
	if [ `use mysql` ] ; then
		einfo "If you plan to use the database dump feature, you'll have to load the table.struct file into mysql."
		einfo "To do this run the following command 'mysql < /etc/${PN}/table.struct'."
		einfo "This will create a database named 'aim' with all the right tables."
		einfo "After that use: 'GRANT ALL ON aim.* TO username@hostname IDENTIFIED BY 'password';'"
		einfo "and go to http://${HOSTNAME}/was/admin.php to fill in the blanks."
	fi
	if [ `use samba` ] ; then
		einfo "--SMB <-Turn SMB lookups 'on' to get NT domain usernames with AIM logins, Off by default."
	fi
}
