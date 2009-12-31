# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/oracle-instantclient-jdbc/oracle-instantclient-jdbc-11.2.0.0.2.ebuild,v 1.1 2009/12/31 10:45:09 dertobi123 Exp $

inherit eutils

MY_P_amd64="${PN/oracle-instantclient-/oracle-instantclient11.2-}-${PV}-1.x86_64"

S="${WORKDIR}"
DESCRIPTION="Oracle 11g client installation for Linux: JDBC supplement"
HOMEPAGE="http://www.oracle.com/technology/tech/oci/instantclient/index.html"
SRC_URI="amd64? ( ${MY_P_amd64}.zip )"

LICENSE="OTN"
SLOT="0"
KEYWORDS="-* ~amd64"
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
	eerror "and download the JDBC supplemental package.  Put it in:"
	eerror "  ${DISTDIR}"
	eerror "after downloading it."
}

src_unpack() {
	unzip "${DISTDIR}"/${MY_P}.zip
}

src_install() {
	dodir /usr/$(get_libdir)/oracle/${PV}/client/lib
	cd "${S}"/instantclient_11_2
	insinto /usr/$(get_libdir)/oracle/${PV}/client/lib
	doins libheteroxa11.so orai18n.jar
}

pkg_postinst() {
	elog "The JDBC supplement package for Oracle 11g has been installed."
	elog "You may wish to install the oracle-instantclient-sqlplus (for "
	elog "running the SQL*Plus application) package as well."
}
