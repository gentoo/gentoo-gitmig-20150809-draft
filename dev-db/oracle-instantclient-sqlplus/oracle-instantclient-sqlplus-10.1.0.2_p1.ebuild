# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/oracle-instantclient-sqlplus/oracle-instantclient-sqlplus-10.1.0.2_p1.ebuild,v 1.5 2006/01/21 16:12:54 dertobi123 Exp $

inherit eutils

MY_PV=${PV/_p/-}
MY_P="${PN}-${MY_PV}.i386"


S=${WORKDIR}
DESCRIPTION="Oracle 10g client installation for Linux: SQL*Plus"
HOMEPAGE="http://otn.oracle.com/software/tech/oci/instantclient/htdocs/linuxsoft.html"
SRC_URI="${MY_P}.rpm"

LICENSE="OTN"
SLOT="${PV}"
KEYWORDS="~x86"
RESTRICT="fetch"
IUSE=""

DEPEND="app-arch/rpm2targz
		>=dev-db/oracle-instantclient-basic-10.1.0.2_p1"

pkg_nofetch() {
	eerror "Please go to:"
	eerror "  ${HOMEPAGE}"
	eerror "and download the SQL*Plus package.  Put it in:"
	eerror "  ${DISTDIR}"
	eerror "after downloading it."
}

src_unpack() {
	rpm2targz ${DISTDIR}/${MY_P}.rpm
	tar zxf ${WORKDIR}/${MY_P}.tar.gz 2>/dev/null
}

src_install() {
	dodir /usr/lib/oracle/10.1.0.2/client/lib
	cd ${S}/usr/lib/oracle/10.1.0.2/client/lib
	insinto /usr/lib/oracle/10.1.0.2/client/lib
	doins glogin.sql libsqlplus.so

	dodir /usr/lib/oracle/10.1.0.2/client/bin
	cd ${S}/usr/lib/oracle/10.1.0.2/client/bin
	exeinto /usr/lib/oracle/10.1.0.2/client/bin
	doexe sqlplus

	dodir /usr/bin
	dosym ${D}/usr/lib/oracle/10.1.0.2/client/bin/sqlplus /usr/bin/sqlplus
}

pkg_postinst() {
	echo
	einfo "The SQL*Plus package for Oracle 10g has been installed."
	einfo "You may wish to install the oracle-instantclient-jdbc (for"
	einfo "the supplemental JDBC functionality) package as well."
	einfo
	einfo "If you have any questions, be sure to read the README:"
	einfo "http://otn.oracle.com/docs/tech/sql_plus/10102/readme_ic.htm"
	echo
}
