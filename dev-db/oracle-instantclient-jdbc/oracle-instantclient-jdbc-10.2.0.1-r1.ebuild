# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/oracle-instantclient-jdbc/oracle-instantclient-jdbc-10.2.0.1-r1.ebuild,v 1.3 2006/03/19 19:18:02 halcy0n Exp $

inherit eutils

MY_P_x86="${PN/oracle-/}-linux32-${PV}-20050713"
MY_P_amd64="${PN/oracle-/}-linux-x86-64-${PV}-20051025"


S=${WORKDIR}
DESCRIPTION="Oracle 10g client installation for Linux: JDBC supplement"
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
	eerror "and download the JDBC supplemental package.  Put it in:"
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
	doins libheteroxa10.so orai18n.jar
}

pkg_postinst() {
	einfo "The JDBC supplement package for Oracle 10g has been installed."
	einfo "You may wish to install the oracle-instantclient-sqlplus (for "
	einfo "running the SQL*Plus application) package as well."
}
