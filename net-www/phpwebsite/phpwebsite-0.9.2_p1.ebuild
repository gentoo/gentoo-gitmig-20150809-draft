# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Don Seiler <rizzo@gentoo.org>
# $Header $


HOSTNAME=`hostname`
DESCRIPTION="phpWebSite provides a complete web site content management system. Web-based administration allows for easy maintenance of interactive, community-driven web sites."
HOMEPAGE="http://phpwebsite.appstate.edu"
MY_PV="${PV/_p/-}"
S="${WORKDIR}/${PN}-${MY_PV}-full"
SRC_URI="mirror://sourceforge/phpwebsite/${PN}-${MY_PV}-full.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND="virtual/php"

HTTPD_ROOT="`grep '^DocumentRoot' /etc/apache/conf/apache.conf | cut -d\  -f2`"
[ -z "${HTTPD_ROOT}" ] && HTTPD_ROOT="`grep '^DocumentRoot' /etc/apache2/conf/apache.conf | cut -d\  -f2`"
[ -z "${HTTPD_ROOT}" ] && HTTPD_ROOT="/home/httpd/htdocs"
HTTPD_USER="apache"
HTTPD_GROUP="apache"


src_compile() {            
	echo "Nothing to compile" 
}

src_install() {
	cd ${S}
	dodir ${HTTPD_ROOT}/phpwebsite
	cp -r * ${D}/${HTTPD_ROOT}/phpwebsite
}

pkg_postinst() {
	einfo
	einfo "You will need to create a database for phpWebSite"
	einfo "on your own before starting setup.  You will also need"
	einfo "to run:"
	einfo
	einfo "${HTTPD_ROOT}/phpwebsite/setup/secure_setup.sh setup"
	einfo
	einfo "Once you have a database ready proceed to"
	einfo "http://$HOSTNAME/phpwebsite to continue installation."
	einfo
	einfo "Once you are done with installation you need to run"
	einfo
	einfo "${HTTPD_ROOT}/phpwebsite/setup/secure_phpws.sh run apache users"
	einfo
}
