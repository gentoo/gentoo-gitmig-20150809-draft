# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/aimsniff/aimsniff-0.9.ebuild,v 1.1 2003/12/08 18:25:08 zhen Exp $

MY_P="${P}b"

if [ `use apache2` ]
then
	inherit webapp-apache
fi

DESCRIPTION="utility for monitoring and archiving AOL Instant Messenger messages across a network"
HOMEPAGE="http://www.aimsniff.com/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz
	 	apache2? ( mirror://sourceforge/${PN}/was_0.1.1b.tar.gz )"
RESTRICT="nomirror"

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
	dev-perl/Proc-Simple
	dev-perl/DBI
	dev-perl/Unix-Syslog
	mysql? ( dev-db/mysql dev-perl/DBD-mysql )
	samba? ( net-fs/samba )"

S=${WORKDIR}/${MY_P}

src_install() {
	newsbin aimSniff.pl aimsniff
	insinto /etc/${PN}
	doins aimsniff.config
	insinto /usr/share/doc/${P}
	doins table.struct
	dodoc README ChangeLog

	if [ `use apache2` ]
	then
		webapp-detect || NO_WEBSERVER=1
		dodir ${HTTPD_ROOT}
		mv ../was ${D}/${HTTPD_ROOT}
		cd ${D}/${HTTPD_ROOT}
		chown -R ${HTTPD_USER}:${HTTPD_GROUP} *
	fi
}

pkg_setup ()
{
	if [ `use apache2` ]
	then
		webapp-detect || NO_WEBSERVER=1
		webapp-pkg_setup $NO_WEBSERVER
	fi
}

pkg_postinst() {
	echo
	if [ `use mysql` ] ; then
		einfo "To create and enable the mysql database, please run: "
		einfo "ebuild /var/db/pkg/net-analyzer/${P}/${P}.ebuild config"
	fi
	if [ `use apache2` ]
	then
		einfo "Go to http://${HOSTNAME}/was/admin.php to configure WAS."
	fi
	echo
}

pkg_config() {
	echo
	einfo "Creating mysql database aimsniff using /usr/share/doc/${P}/table.struct:"
	echo -n "Please enter your mysql root password: "
	read mysql_root
	/usr/bin/mysqladmin -p$mysql_root -u root create aimsniff
	/usr/bin/mysql -p$mysql_root -u root aimsniff < /usr/share/doc/${P}/table.struct
	echo -n "Please enter your username that you want to connect to the database with: "
	read user
	echo -n "Please enter the password that you want to use for your database: "
	read password
	einfo "Granting permisions on database using 'GRANT ALL ON aimsniff.* TO $user IDENTIFIED BY '$password';'"
	echo "GRANT ALL ON aimsniff.* TO $user@localhost IDENTIFIED BY '$password';" | /usr/bin/mysql -p$mysql_root -u root aimsniff
	echo
}
