# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/gentoo-x86

inherit perl-module

DESCRIPTION="rackview is a tool for visualizing the layout of rack-mounted equipment. The purpose of this tool is to assist in planning and tracking of hardware changes to racks in a data center, and to provide a host-oriented interface into other database tools."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://rackview.sf.net"

SLOT="0"
KEYWORDS="~x86"
LICENSE="Artistic"
IUSE="apache2 mysql"
DEPEND="dev-lang/perl
	dev-perl/GD
	dev-perl/DBI
	mysql? ( dev-db/mysql )"
DOCS="ChangeLog COPYING README* doc/*"

#In case of Apache

use apache2 || HTTPD_ROOT="`grep '^DocumentRoot' /etc/apache/conf/apache.conf | cut -d\  -f2`" \
			|| HTTPD_USER="`grep '^User' /etc/apache/conf/commonapache.conf | cut -d \  -f2`" \
			|| HTTPD_GROUP="`grep '^Group' /etc/apache/conf/commonapache.conf | cut -d \  -f2`"

#In case of Apache2

use apache2 && HTTPD_ROOT="`grep '^DocumentRoot' /etc/apache2/conf/apache2.conf | cut -d\  -f2`" \
			&& HTTPD_USER="`grep '^User' /etc/apache2/conf/commonapache2.conf | cut -d \  -f2`" \
			&& HTTPD_GROUP="`grep '^Group' /etc/apache2/conf/commonapache2.conf | cut -d \  -f2`"

# Else use defaults

[ -z "${HTTPD_ROOT}" ] && HTTPD_ROOT="/home/httpd/htdocs"
[ -z "${HTTPD_USER}" ] && HTTPD_USER="apache"
[ -z "${HTTPD_GROUP}" ] && HTTPD_GROUP="apache"

src_install() {
	
	perl-module_src_install
	
	dodoc ${DOCS}
	
	#Correct configfile
	dodir /etc/${PN}
	mv ${D}usr/etc/eidetic/* ${D}etc/${PN}
	cd ${D}etc/${PN}
	cp rackview.conf rackview.conf.orig \
		&& sed -e "s:eidetic:${PN}:" rackview.conf.orig > rackview.conf \
		&& rm rackview.conf.orig \
		|| ewarn "Please check /etc/${PN}/rackview.conf"
	rm -fr ${D}usr/etc											#Remove trash
	
	einfo "Installing example in ${HTTPD_ROOT}/${PN}"
	cd ${S}
	dodir ${HTTPD_ROOT}/${PN}
	mv example/* ${D}${HTTPD_ROOT}/${PN}
	mv ${D}usr/var/www/html/* ${D}${HTTPD_ROOT}
	rm -fr ${D}usr/var											#Remove trash
	
	#Install .cgi
	dodir ${HTTPD_ROOT}/../cgi-bin
	cp cgi-bin/rackview.cgi ${D}${HTTPD_ROOT}/../cgi-bin/rackview.cgi.orig \
		&& cd ${D}${HTTPD_ROOT}/../cgi-bin \
		&& sed -e "s:/var/www/html:${HTTPD_ROOT}:" \
		       -e "s:eidetic:${PN}:" rackview.cgi.orig > rackview.cgi \
		&& chmod u+x rackview.cgi \
		&& rm rackview.cgi.orig	\
		|| ewarn "Please copy (& check) rackview.cgi manually." 
	
	#Script needs to change also
	cd ${D}usr/bin
	cp erackview erackview.orig \
		&& sed -e "s:eidetic:${PN}:" erackview.orig > erackview \
		&& chmod ugo+x erackview \
		&& rm erackview.orig \
		|| ewarn "Please check script 'erackview'."
		
	#Making sure HTTPD_USER owns all files
	cd ${D}
	chown -R ${HTTPD_USER}:${HTTPD_GROUP} * || ewarn "Check if ${HTTPD_USER} owns all files."
}

pkg_postinst() {
	use mysql && einfo "To load data from mysql, change 'dat' in 'db' in /etc/${PN}/rackview.conf" \
		&& einfo "SQL files for creating these tables are available in ${S}/sql"
	einfo "Now go to http://${HOSTNAME}/rackview/ to test."
}
