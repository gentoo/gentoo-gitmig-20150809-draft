# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/oracle-instantclient-basic/oracle-instantclient-basic-10.1.0.5.ebuild,v 1.2 2006/12/26 18:48:39 dertobi123 Exp $

inherit eutils

MY_P="${PN/oracle-/}-linux32-${PV}-20060511"
MY_PSDK="${MY_P/basic/sdk}"

S=${WORKDIR}
DESCRIPTION="Oracle 10g client installation for Linux with SDK"
HOMEPAGE="http://otn.oracle.com/software/tech/oci/instantclient/htdocs/linuxsoft.html"
SRC_URI="${MY_P}.zip ${MY_PSDK}.zip"

LICENSE="OTN"
SLOT="${PV}"
KEYWORDS="x86"
RESTRICT="fetch"
IUSE=""

DEPEND="app-arch/unzip"
# RDEPEND does not needs unzip

pkg_nofetch() {
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
	cd ${S}/instantclient10_1
	insinto /usr/lib/oracle/${PV}/client/lib
	doins *.jar *.so *.so.10.1

	# fixes symlinks
	dosym /usr/lib/oracle/${PV}/client/lib/libocci.so.10.1 /usr/lib/oracle/${PV}/client/lib/libocci.so
	dosym /usr/lib/oracle/${PV}/client/lib/libclntsh.so.10.1 /usr/lib/oracle/${PV}/client/lib/libclntsh.so

	# includes
	dodir /usr/lib/oracle/${PV}/client/include
	insinto /usr/lib/oracle/${PV}/client/include
	cd ${S}/instantclient10_1/sdk/include
	doins *.h
	# link to original location
	dodir /usr/include/oracle/${PV}/
	ln -s ${D}/usr/lib/oracle/${PV}/client/include ${D}/usr/include/oracle/${PV}/client

	# share info
	cd ${S}/instantclient10_1/sdk/demo
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
	ewarn "ORACLE_HOME (and others) are set in /etc/env.d/50oracle-instantclient-basic"
}
