# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/oracle-instantclient-basic/oracle-instantclient-basic-10.1.0.3.ebuild,v 1.3 2005/07/09 19:48:20 swegener Exp $

inherit eutils

MY_P="${P}-1.i386"
MY_PSDK="${MY_P/basic/devel}"

S=${WORKDIR}
DESCRIPTION="Oracle 10g client installation for Linux with SDK"
HOMEPAGE="http://otn.oracle.com/software/tech/oci/instantclient/htdocs/linuxsoft.html"
SRC_URI="${MY_P}.rpm ${MY_PSDK}.rpm"

LICENSE="OTN"
SLOT="${KV}"
KEYWORDS="~x86"
RESTRICT="fetch"
IUSE=""

DEPEND="app-arch/rpm2targz"

pkg_nofetch() {
	eerror "Please go to:"
	eerror "  ${HOMEPAGE}"
	eerror "and download the Basic client package with SDK, which are:"
	eerror "  ${MY_P}.rpm"
	eerror "  ${MY_PSDK}.rpm"
	eerror "Then after downloading put them in:"
	eerror "  ${DISTDIR}"
}

src_unpack() {
	rpm2targz ${DISTDIR}/${MY_P}.rpm
	tar zxf ${WORKDIR}/${MY_P}.tar.gz
	rpm2targz ${DISTDIR}/${MY_PSDK}.rpm
	tar zxf ${WORKDIR}/${MY_PSDK}.tar.gz

	# this is needed because of sdk package as we handle symlinks using dosym in src_install
	rm -f ${S}/usr/lib/oracle/${PV}/client/lib/libclntsh.so
	rm -f ${S}/usr/lib/oracle/${PV}/client/lib/libocci.so
}

src_install() {
	# library
	dodir /usr/lib/oracle/${PV}/client/lib
	cd ${S}/usr/lib/oracle/${PV}/client/lib
	insinto /usr/lib/oracle/${PV}/client/lib
	doins *.jar *.so *.so.10.1

	# fixes symlinks
	dosym /usr/lib/oracle/${PV}/client/lib/libocci.so.10.1 /usr/lib/oracle/${PV}/client/lib/libocci.so
	dosym /usr/lib/oracle/${PV}/client/lib/libclntsh.so.10.1 /usr/lib/oracle/${PV}/client/lib/libclntsh.so

	# includes
	dodir /usr/lib/oracle/${PV}/client/include
	insinto /usr/lib/oracle/${PV}/client/include
	cd ${S}/usr/include/oracle/${PV}/client
	doins *.h
	# link to oroginal location
	dodir /usr/include/oracle/${PV}/
	ln -s ${D}/usr/lib/oracle/${PV}/client/include ${D}/usr/include/oracle/${PV}/client

	# share info
	cd ${S}/usr/share/oracle/${PV}/client
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
