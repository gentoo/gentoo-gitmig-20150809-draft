# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/squidalyser/squidalyser-0.2.55.ebuild,v 1.4 2003/04/18 18:17:11 seemant Exp $

inherit eutils

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="Interactive log analyser for the Squid proxy."
HOMEPAGE="http://ababa.org"
SRC_URI="http://ababa.org/dist/${P}.tar.gz
	mirror://gentoo/${P}-gentoo.diff.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~alpha ~ppc"

RDEPEND="net-www/squid
	dev-lang/perl
	dev-perl/CGI
	dev-perl/DBI
	dev-perl/DBD-mysql
	dev-perl/Time-modules
	dev-perl/Time-HiRes
	dev-perl/GD
	dev-perl/GDGraph
	dev-perl/GDTextUtil
	dev-perl/URI
	dev-db/mysql
	net-www/apache
	net-www/squid"
	
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${P}-gentoo.diff
}

src_install() {
	
	# Create a user directory for squidalyser. Put the squidparse and sql scripts into it
	dodir /usr/share/squidalyser/squidparse
	cp ${S}/squidparse/squidparse.pl ${D}/usr/share/squidalyser/squidparse/squidparse.pl
	dodir /etc/squidalyser
	cp ${S}/squidparse/squidalyser.conf ${D}/etc/squidalyser/squidalyser.conf
	
	dodir /usr/share/squidalyser/sql
	cp ${S}/sql/* ${D}/usr/share/squidalyser/sql
	dodir /usr/share/squidalyser/docs
	cp ${S}/docs/* ${D}/usr/share/squidalyser/docs
	
	# Put the apache scripts under the apache directory
	chown apache ${S}/cgi-bin/*
	chmod 755 ${S}/cgi-bin/*
	
	dodir /home/httpd/cgi-bin
	cp ${S}/cgi-bin/* ${D}/home/httpd/cgi-bin
	dodir /home/httpd/icons
	cp ${S}/icons/* ${D}/home/httpd/icons 	
}

pkg_preinst() {
	ewarn "pkg_preinst()"
}

pkg_postinst() {
	ewarn "pkg_postinst"
	# start up mysql if it isn't already running
	mysqlstat=`/etc/init.d/mysql status | grep -c started`
	if [ ${mysqlstat} -lt 1 ]
	then
		/etc/init.d/mysql start
		sleep 3
	fi
	# create the basic database
	ewarn "configure mysql"
	mysql --execute="drop database squid"
	mysql --execute="create database squid"
	mysql --execute="grant all privileges on squid.* to squidalyser@localhost identified by 'tr!red$';" 
	mysql squid < /usr/share/squidalyser/sql/squidalyser.sql
	mysql squid --execute="delete from logfile"
				
	ewarn "update crontab"
	# Update the crontab for the squidparse routine
	spcount=`grep -c squidparse.pl /etc/crontab`
	if [ ${spcount} -gt 1 ] 
	then
		ewarn "More than one entry in /etc/crontab. Please check."
	elif [ ${spcount} -eq 1 ] 
	then
		ewarn "squidparse.pl entry already in /etc/crontab, leaving alone"
	else
		echo "0 3  * * *      root    /usr/share/squidalyser/squidparse/squidparse.pl" >> /etc/crontab
	fi
	
	ewarn "Running squidparse for first time, this may take several minutes"
	/usr/share/squidalyser/squidparse/squidparse.pl
}
