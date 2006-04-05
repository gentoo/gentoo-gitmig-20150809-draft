# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/oracle-instantclient-sqlplus/oracle-instantclient-sqlplus-10.2.0.2.ebuild,v 1.1 2006/04/05 18:59:58 dertobi123 Exp $

inherit eutils

MY_P_x86="${PN/oracle-/}-linux32-${PV}-20060331"
MY_P_amd64="${PN/oracle-/}-linux-x86-64-${PV}-20060228"

S=${WORKDIR}
DESCRIPTION="Oracle 10g client installation for Linux: SQL*Plus"
HOMEPAGE="http://otn.oracle.com/software/tech/oci/instantclient/htdocs/linuxsoft.html"
SRC_URI="x86? ( ${MY_P_x86}.zip )
		 amd64? ( ${MY_P_amd64}.zip )"

LICENSE="OTN"
SLOT="${PV}"
KEYWORDS="-* ~amd64 ~x86"
RESTRICT="fetch"
IUSE=""

RDEPEND=">=dev-db/oracle-instantclient-basic-${PV}"
DEPEND="${RDEPEND}
	app-arch/unzip"

pkg_setup() {
	MY_P=MY_P_${ARCH}
	export MY_P=${!MY_P}
}


pkg_nofetch() {
	eerror "Please go to:"
	eerror "  ${HOMEPAGE}"
	eerror "and download the SQL*Plus package.  Put it in:"
	eerror "  ${DISTDIR}"
	eerror "after downloading it."
}

src_unpack() {
	unzip ${DISTDIR}/${MY_P}.zip
}

src_install() {
	dodir /usr/lib/oracle/${PV}/client/lib
	cd ${S}/instantclient_10_2
	insinto /usr/lib/oracle/${PV}/client/lib
	doins glogin.sql libsqlplus.so libsqlplusic.so

	dodir /usr/lib/oracle/${PV}/client/bin
	cd ${S}/instantclient_10_2
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
