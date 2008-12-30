# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/oracle-instantclient-odbc/oracle-instantclient-odbc-11.1.0.7.0.ebuild,v 1.1 2008/12/30 20:51:58 dertobi123 Exp $

inherit eutils

MY_P_x86="${PN/oracle-/}-linux32-${PV/7.0/7}"

DESCRIPTION="Oracle 11g client installation ODBC supplement"
HOMEPAGE="http://www.oracle.com/technology/tech/oci/instantclient/index.html"
SRC_URI="x86? ( ${MY_P_x86}.zip )"

LICENSE="OTN"
SLOT="0"
KEYWORDS="-* ~x86"
RESTRICT="fetch"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="dev-db/oracle-instantclient-basic"

S="${WORKDIR}"

my_arch() {
	MY_P=MY_P_${ARCH}
	export MY_P=${!MY_P}
}

pkg_setup() {
	my_arch
}

pkg_nofetch() {
	my_arch
	eerror "Please go to:"
	eerror "  ${HOMEPAGE}"
	eerror "select your platform and download the"
	eerror "ODBC supplement, which is:"
	eerror "  ${MY_P}.zip"
	eerror "Then after downloading put it in:"
	eerror "  ${DISTDIR}"
}

src_unpack() {
	unzip "${DISTDIR}"/${MY_P}.zip || die "unsuccesful unzip ${MY_P}.zip"
}

src_install() {
	# library
	dodir /usr/$(get_libdir)/oracle/${PV}/client/lib
	cd "${S}"/instantclient_11_1
	insinto /usr/$(get_libdir)/oracle/${PV}/client/lib
	doins *.so.11.1

	# fixes symlinks
	dosym /usr/$(get_libdir)/oracle/${PV}/client/lib/libsqora.so.11.1 /usr/$(get_libdir)/oracle/${PV}/client/lib/libsqora.so

	# odbc_update_ini.sh
	dodir /usr/$(get_libdir)/oracle/${PV}/client/bin
	cd "${S}"/instantclient_11_1
	exeinto /usr/$(get_libdir)/oracle/${PV}/client/bin
	doexe odbc_update_ini.sh

	# documentation
	dodoc *htm*
}
