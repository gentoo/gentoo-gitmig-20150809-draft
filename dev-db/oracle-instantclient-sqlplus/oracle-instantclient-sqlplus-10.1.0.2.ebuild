# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/oracle-instantclient-sqlplus/oracle-instantclient-sqlplus-10.1.0.2.ebuild,v 1.1 2004/03/22 21:35:34 rizzo Exp $

inherit eutils

MY_P="${P}-1.i386"

S=${WORKDIR}
DESCRIPTION="Oracle 10g client installation for Linux: SQL*Plus"
HOMEPAGE="http://otn.oracle.com/software/tech/oci/instantclient/htdocs/linuxsoft.html"
SRC_URI="${MY_P}.rpm"

LICENSE="OTN"
SLOT="${KV}"
KEYWORDS="~x86"
RESTRICT="fetch"

DEPEND="app-arch/rpm2targz
		=dev-db/oracle-instantclient-basic-10.1.0.2"

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
	mv ${S}/usr ${D}
	dosym /usr/lib/oracle/${PV}/client/bin/sqlplus /usr/bin/sqlplus
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
