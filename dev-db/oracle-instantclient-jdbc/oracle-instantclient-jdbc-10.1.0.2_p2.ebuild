# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/oracle-instantclient-jdbc/oracle-instantclient-jdbc-10.1.0.2_p2.ebuild,v 1.4 2006/01/21 16:15:04 dertobi123 Exp $

inherit eutils

MY_PV=${PV/_p/-}
MY_P="${PN}-${MY_PV}.i386"

S=${WORKDIR}
DESCRIPTION="Oracle 10g client installation for Linux: JDBC supplement"
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
	eerror "and download the JDBC supplemental package.  Put it in:"
	eerror "  ${DISTDIR}"
	eerror "after downloading it."
}

src_unpack() {
	rpm2targz ${DISTDIR}/${MY_P}.rpm
	tar zxf ${WORKDIR}/${MY_P}.tar.gz
}

src_install() {
	dodir /usr/lib/oracle/10.1.0.2/client/lib
	cd ${S}/usr/lib/oracle/10.1.0.2/client/lib
	insinto /usr/lib/oracle/10.1.0.2/client/lib
	doins libheteroxa10.so ocrs12.jar orai18n.jar
}

pkg_postinst() {
	echo
	einfo "The JDBC supplement package for Oracle 10g has been installed."
	einfo "You may wish to install the oracle-instantclient-sqlplus (for "
	einfo "running the SQL*Plus application) package as well."
	echo
}
