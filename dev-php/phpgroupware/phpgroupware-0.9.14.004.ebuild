# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-php/phpgroupware/phpgroupware-0.9.14.004.ebuild,v 1.1 2003/07/05 12:06:35 mholzer Exp $

S=${WORKDIR}/${PN}
HTTPD_ROOT="/home/httpd/htdocs"
HTTPD_USER="apache"
HTTPD_GROUP="apache"

DESCRIPTION="The phpGroupWare intranet/groupware tool and application framework."
SRC_URI="mirror://sourceforge/phpgroupware/${P}.tar.bz2"
HOMEPAGE="http://www.phpgroupware.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha"
IUSE=""

DEPEND="virtual/php
	dev-db/mysql"


pkg_setup() {
	if [ -L ${HTTPD_ROOT}/phpgroupware ] ; then
		ewarn "You need to unmerge your old phpGroupWare version first."
		ewarn "phpGroupWare will be installed into ${HTTPD_ROOT}/phpgroupware"
		ewarn "directly instead of a version-dependant directory."
		die "need to unmerge old version first"
	fi
}

src_compile() {
	#nothing to compile
	echo "Nothing to compile"
}

src_install () {
	dodir ${HTTPD_ROOT}/phpgroupware
	cd ${WORKDIR} 
	cp -r . ${D}/${HTTPD_ROOT}
	cd ${D}/${HTTPD_ROOT}
	chown -R ${HTTPD_USER}.${HTTPD_GROUP} phpgroupware
	chmod -R 700 phpgroupware/files
}

pkg_postinst() {
	einfo "Follow the instructions at http://docs.phpgroupware.org/12-docs/html/admin/x62.html#AEN134 "
	einfo "to complete the install.  You need to add MySQL users and configure phpGroupWare"
}
