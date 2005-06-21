# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/oracle-instantclient-jdbc/oracle-instantclient-jdbc-10.1.0.4.ebuild,v 1.1 2005/06/21 19:41:24 radek Exp $

inherit eutils

MY_P="${PN/oracle-/}-linux32-${PV}-20050525"

S=${WORKDIR}
DESCRIPTION="Oracle 10g client installation for Linux: JDBC supplement"
HOMEPAGE="http://otn.oracle.com/software/tech/oci/instantclient/htdocs/linuxsoft.html"
SRC_URI="${MY_P}.zip"

LICENSE="OTN"
SLOT="${KV}"
KEYWORDS="~x86"
RESTRICT="fetch"
IUSE=""

DEPEND=">=dev-db/oracle-instantclient-basic-${PV}"

pkg_nofetch() {
	eerror "Please go to:"
	eerror "  ${HOMEPAGE}"
	eerror "and download the JDBC supplemental package.  Put it in:"
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
	doins libheteroxa10.so ocrs12.jar orai18n.jar
}

pkg_postinst() {
	einfo "The JDBC supplement package for Oracle 10g has been installed."
	einfo "You may wish to install the oracle-instantclient-sqlplus (for "
	einfo "running the SQL*Plus application) package as well."
}
