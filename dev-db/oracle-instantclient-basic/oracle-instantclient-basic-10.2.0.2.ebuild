# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/oracle-instantclient-basic/oracle-instantclient-basic-10.2.0.2.ebuild,v 1.3 2006/04/17 11:58:22 dertobi123 Exp $

inherit eutils

MY_P_x86="${PN/oracle-/}-linux32-${PV}-20060331"
MY_PSDK_x86="${MY_P_x86/basic/sdk}"

MY_P_amd64="${PN/oracle-/}-linux-x86-64-${PV}-20060228"
MY_PSDK_amd64="${MY_P_amd64/basic/sdk}"

S=${WORKDIR}
DESCRIPTION="Oracle 10g client installation for Linux with SDK"
HOMEPAGE="http://otn.oracle.com/software/tech/oci/instantclient/htdocs/linuxsoft.html"
SRC_URI="x86? ( ${MY_P_x86}.zip ${MY_PSDK_x86}.zip )
		 amd64? ( ${MY_P_amd64}.zip ${MY_PSDK_amd64}.zip )"

LICENSE="OTN"
SLOT="${PV}"
KEYWORDS="-* ~amd64 ~x86"
RESTRICT="fetch"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="|| ( =sys-libs/libstdc++-v3-3.3* =sys-devel/gcc-3.3* )
	app-admin/eselect-oracle"

my_arch() {
	MY_P=MY_P_${ARCH}
	export MY_P=${!MY_P}
	MY_PSDK=MY_PSDK_${ARCH}
	export MY_PSDK=${!MY_PSDK}
}

pkg_setup() {
	my_arch
}

pkg_nofetch() {
	my_arch
	eerror "Please go to:"
	eerror "  ${HOMEPAGE}"
	eerror "and download the Basic client package with SDK, which are:"
	eerror "  ${MY_P}.zip"
	eerror "  ${MY_PSDK}.zip"
	eerror "Then after downloading put them in:"
	eerror "  ${DISTDIR}"
}

src_unpack() {
	unzip ${DISTDIR}/${MY_P}.zip || die "unsuccesful unzip ${MY_P}.zip"
	unzip ${DISTDIR}/${MY_PSDK}.zip || die "unsuccesful unzip ${MY_PSDK}.zip"
}

src_install() {
	# library
	dodir /usr/lib/oracle/${PV}/client/lib
	cd ${S}/instantclient_10_2
	insinto /usr/lib/oracle/${PV}/client/lib
	doins *.jar *.so *.so.10.1

	# fixes symlinks
	dosym /usr/lib/oracle/${PV}/client/lib/libocci.so.10.1 /usr/lib/oracle/${PV}/client/lib/libocci.so
	dosym /usr/lib/oracle/${PV}/client/lib/libclntsh.so.10.1 /usr/lib/oracle/${PV}/client/lib/libclntsh.so

	# includes
	dodir /usr/lib/oracle/${PV}/client/include
	insinto /usr/lib/oracle/${PV}/client/include
	cd ${S}/instantclient_10_2/sdk/include
	doins *.h
	# link to original location
	dodir /usr/include/oracle/${PV}/
	ln -s ${D}/usr/lib/oracle/${PV}/client/include ${D}/usr/include/oracle/${PV}/client

	# share info
	cd ${S}/instantclient_10_2/sdk/demo
	dodoc *

	# Add OCI libs to library path
	dodir /etc/env.d
	echo "ORACLE_HOME=/usr/lib/oracle/${PV}/client" >> ${D}/etc/env.d/50oracle-instantclient-basic
	echo "LDPATH=/usr/lib/oracle/${PV}/client/lib" >> ${D}/etc/env.d/50oracle-instantclient-basic
	echo "C_INCLUDE_PATH=/usr/lib/oracle/${PV}/client/include" >> ${D}/etc/env.d/50oracle-instantclient-basic
}

pkg_postinst() {
	einfo "The Basic client page for Oracle 10g has been installed."
	einfo "You may also wish to install the oracle-instantclient-jdbc (for"
	einfo "supplemental JDBC functionality with Oracle) and the"
	einfo "oracle-instantclient-sqlplus (for running the SQL*Plus application)"
	einfo "packages as well."
	einfo
	einfo "Examples are located in /usr/share/doc/${PF}/"
	einfo
	ewarn "A new eselect module has been added to easily switch between"
	ewarn "different Instantclient versions and to set your ORACLE_HOME."
	ewarn "See 'eselect oracle help' for reference"
}
