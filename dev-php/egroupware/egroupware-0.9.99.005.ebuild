# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/egroupware/egroupware-0.9.99.005.ebuild,v 1.4 2003/10/21 15:49:43 mholzer Exp $

MY_P=eGroupWare-${PV}
S=${WORKDIR}/${PN}
HTTPD_ROOT="/home/httpd/htdocs"
HTTPD_USER="apache"
HTTPD_GROUP="apache"

DESCRIPTION="Web-based GroupWare suite. It contains many modules"
HOMEPAGE="http://www.eGroupWare.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}-0.tar.bz2"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~amd64 ~sparc ~hppa ~arm"

DEPEND="virtual/php
	dev-db/mysql"

pkg_setup() {
	if [ -L ${HTTPD_ROOT}/${PN} ] ; then
		ewarn "You need to unmerge your old egroupware version first."
		ewarn "egroupware will be installed into ${HTTPD_ROOT}/${PN}"
		ewarn "directly instead of a version-dependant directory."
		die "need to unmerge old version first"
	fi
}

src_compile() {
	#nothing to compile
	echo "Nothing to compile"
}

src_install() {
	dodir ${HTTPD_ROOT}/${PN}
	cd ${WORKDIR}
	cp -r . ${D}/${HTTPD_ROOT}
	cd ${D}/${HTTPD_ROOT}
	chown -R ${HTTPD_USER}.${HTTPD_GROUP} ${PN}
	dohtml ${PN}/doc/en_US/html/admin/*.html
}

pkg_postinst() {
	einfo "Follow the instructions at /usr/share/doc/${PF}/html/x62.html#AEN134 "
	einfo "to complete the install.  You need to add MySQL users and configure egroupware"
}
