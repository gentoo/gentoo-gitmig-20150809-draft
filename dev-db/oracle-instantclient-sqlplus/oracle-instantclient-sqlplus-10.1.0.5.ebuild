# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/oracle-instantclient-sqlplus/oracle-instantclient-sqlplus-10.1.0.5.ebuild,v 1.2 2007/01/27 14:15:07 dertobi123 Exp $

inherit eutils

MY_P="${PN/oracle-/}-linux32-${PV}-20060511"

S=${WORKDIR}
DESCRIPTION="Oracle 10g client installation for Linux: SQL*Plus"
HOMEPAGE="http://www.oracle.com/technology/tech/oci/instantclient/index.html"
SRC_URI="${MY_P}.zip"

LICENSE="OTN"
SLOT="${PV}"
KEYWORDS="~x86"
RESTRICT="fetch"
IUSE=""

RDEPEND=">=dev-db/oracle-instantclient-basic-${PV}"
DEPEND="${RDEPEND}
	app-arch/unzip"

pkg_nofetch() {
	eerror "Please go to:"
	eerror "  ${HOMEPAGE}"
	eerror "select your platform and download the"
	eerror "SQL*Plus package.  Put it in:"
	eerror "  ${DISTDIR}"
	eerror "after downloading it."
}

src_unpack() {
	unzip ${DISTDIR}/${MY_P}.zip
}

src_install() {
	dodir /usr/lib/oracle/${PV}/client/lib
	cd ${S}/instantclient10_1
	insinto /usr/lib/oracle/${PV}/client/lib
	doins glogin.sql libsqlplus.so

	dodir /usr/lib/oracle/${PV}/client/bin
	cd ${S}/instantclient10_1
	exeinto /usr/lib/oracle/${PV}/client/bin
	doexe sqlplus

	dodir /usr/bin
	dosym ${D}/usr/lib/oracle/${PV}/client/bin/sqlplus /usr/bin/sqlplus
}

pkg_postinst() {
	einfo "The SQL*Plus package for Oracle 10g has been installed."
	einfo "You may wish to install the oracle-instantclient-jdbc (for"
	einfo "the supplemental JDBC functionality) package as well."
	einfo
	einfo "If you have any questions, be sure to read the README:"
	einfo "http://otn.oracle.com/docs/tech/sql_plus/10102/readme_ic.htm"
}
