# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/phpgroupware/phpgroupware-0.9.14.007.ebuild,v 1.2 2003/10/21 15:38:58 mholzer Exp $

S=${WORKDIR}/${PN}
HTTPD_ROOT="/home/httpd/htdocs"
HTTPD_USER="apache"
HTTPD_GROUP="apache"

DESCRIPTION="intranet/groupware tool and application framework"
HOMEPAGE="http://www.phpgroupware.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~alpha ~amd64 ~sparc ~hppa ~arm"

DEPEND="virtual/php
	dev-db/mysql"

pkg_setup() {
	if [ -L ${HTTPD_ROOT}/${PN} ] ; then
		ewarn "You need to unmerge your old phpGroupWare version first."
		ewarn "phpGroupWare will be installed into ${HTTPD_ROOT}/phpgroupware"
		ewarn "directly instead of a version-dependant directory."
		die "need to unmerge old version first"
	fi
}

src_install() {
	dodir ${HTTPD_ROOT}/${PN}
	cd ${WORKDIR}
	cp -r . ${D}/${HTTPD_ROOT}
	cd ${D}/${HTTPD_ROOT}
	chown -R ${HTTPD_USER}.${HTTPD_GROUP} phpgroupware
	dohtml ${PN}/doc/en_US/html/admin/*.html
}

pkg_postinst() {
	einfo "Follow the instructions at /usr/share/doc/${PF}/html/x62.html#AEN134 "
	einfo "to complete the install.  You need to add MySQL users and configure phpGroupWare"
}
