# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/rackview/rackview-0.05.ebuild,v 1.4 2004/01/06 11:59:20 robbat2 Exp $

inherit perl-module

DESCRIPTION="tool for visualizing the layout of rack-mounted equipment"
HOMEPAGE="http://rackview.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86"
IUSE="apache2 mysql"

DEPEND="dev-lang/perl
	dev-perl/GD
	dev-perl/DBI
	mysql? ( dev-db/mysql )"

DOCS="ChangeLog COPYING README* doc/*"

src_install() {
	if [ `use apache2` ] ; then
		#In case of Apache
		HTTPD_ROOT="`grep '^DocumentRoot' /etc/apache2/conf/apache2.conf | cut -d\  -f2`" \
		HTTPD_USER="`grep '^User' /etc/apache2/conf/commonapache2.conf | cut -d \  -f2`" \
		HTTPD_GROUP="`grep '^Group' /etc/apache2/conf/commonapache2.conf | cut -d \  -f2`"
	else
		#In case of Apache2
		HTTPD_ROOT="`grep '^DocumentRoot' /etc/apache/conf/apache.conf | cut -d\  -f2`" \
		HTTPD_USER="`grep '^User' /etc/apache/conf/commonapache.conf | cut -d \  -f2`" \
		HTTPD_GROUP="`grep '^Group' /etc/apache/conf/commonapache.conf | cut -d \  -f2`"
	fi

	# Else use defaults
	[ -z "${HTTPD_ROOT}" ] && HTTPD_ROOT="/home/httpd/htdocs"
	[ -z "${HTTPD_USER}" ] && HTTPD_USER="apache"
	[ -z "${HTTPD_GROUP}" ] && HTTPD_GROUP="apache"

	perl-module_src_install

	dodoc ${DOCS}
	insinto /usr/share/doc/${PF}/sql
	doins sql/*

	#Correct configfile
	dodir /etc/${PN}
	mv ${D}usr/etc/eidetic/* ${D}etc/${PN}
	cd ${D}etc/${PN}
	sed -e "s:eidetic:${PN}:" \
		-e "s:/home/www/site_html/images:${HTTPD_ROOT}:" \
		-e "s:images/rack_images:rack_images:" \
		-i ${PN}.conf || ewarn "Please check /etc/${PN}/${PN}.conf"
	rm -fr ${D}usr/etc											#Remove trash

	einfo "Installing example in ${HTTPD_ROOT}/${PN}"
	cd ${S}
	dodir ${HTTPD_ROOT}/${PN}
	mv example/* ${D}${HTTPD_ROOT}/${PN}
	mv ${D}usr/var/www/html/* ${D}${HTTPD_ROOT}
	rm -fr ${D}usr/var											#Remove trash

	#Install .cgi
	dodir ${HTTPD_ROOT}/../cgi-bin
	cp cgi-bin/rackview.cgi ${D}${HTTPD_ROOT}/../cgi-bin/${PN}.cgi \
		&& cd ${D}${HTTPD_ROOT}/../cgi-bin \
		&& sed -i -e "s:/var/www/html:${HTTPD_ROOT}:" \
		       -e "s:eidetic:${PN}:" ${PN}.cgi \
		&& chmod u+x ${PN}.cgi \
		|| ewarn "Please copy (& check) ${PN}.cgi manually."

	#Script needs to change also
	cd ${D}usr/bin
	sed -i -e "s:eidetic:${PN}:" e${PN} \
		&& chmod ugo+x e${PN} \
		|| ewarn "Please check script 'e${PN}'."

	#Making sure HTTPD_USER owns all files
	cd ${D}
	chown -R ${HTTPD_USER}:${HTTPD_GROUP} * || ewarn "Check if ${HTTPD_USER} owns all files."
}

pkg_postinst() {
	if [ `use mysql` ] ; then
		einfo "To load data from mysql, change 'dat' in 'db'" \
		einfo "in /etc/${PN}/${PN}.conf" \
		einfo "SQL files for creating these tables are available" \
		einfo "in /usr/share/doc/${PF}/sql"
	fi
	einfo "Now go to http://${HOSTNAME}/${PN}/ to test."
}
