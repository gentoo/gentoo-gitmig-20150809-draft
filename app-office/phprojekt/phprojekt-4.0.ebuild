# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/phprojekt/phprojekt-4.0.ebuild,v 1.1 2003/04/19 05:51:14 heim Exp $

# lid of download link
MY_DOWNLOAD_ID=14

HTTPD_ROOT="`grep '^DocumentRoot' /etc/apache/conf/apache.conf | cut -d\  -f2`"
HTTPD_USER="`grep '^User' /etc/apache/conf/commonapache.conf | cut -d \  -f2`"
HTTPD_GROUP="`grep '^Group' /etc/apache/conf/commonapache.conf | cut -d \  -f2`"
[ -z "${HTTPD_ROOT}" ] && HTTPD_ROOT="/home/httpd/htdocs"
[ -z "${HTTPD_USER}" ] && HTTPD_USER="apache"
[ -z "${HTTPD_GROUP}" ] && HTTPD_GROUP="apache"

DESCRIPTION="Project management and coordination system"
HOMEPAGE="http://www.phprojekt.com/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

RDEPEND="virtual/php"

src_install() {
	dodoc ChangeLog install readme
	dodir ${HTTPD_ROOT}/phprojekt
	cp -r . ${D}/${HTTPD_ROOT}/phprojekt
	cd ${D}/${HTTPD_ROOT}
	chown -R ${HTTPD_USER}:${HTTPD_GROUP} phprojekt
}
