# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/oracle-instantclient-basic/oracle-instantclient-basic-10.1.0.2_p1-r1.ebuild,v 1.1 2004/11/19 16:33:52 rizzo Exp $

inherit eutils

MY_PV=${PV/_p/-}
MY_P="${PN}-${MY_PV}.i386"

S=${WORKDIR}
DESCRIPTION="Oracle 10g client installation for Linux"
HOMEPAGE="http://otn.oracle.com/software/tech/oci/instantclient/htdocs/linuxsoft.html"
SRC_URI="${MY_P}.rpm"

LICENSE="OTN"
SLOT="${KV}"
KEYWORDS="~x86"
RESTRICT="fetch"
IUSE=""

DEPEND="app-arch/rpm2targz"

pkg_nofetch() {
	eerror "Please go to:"
	eerror "  ${HOMEPAGE}"
	eerror "and download the Basic client package.  Put it in:"
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
	doins *.jar *.so *.so.10.1

	# Add OCI libs to library path
	dodir /etc/env.d
	echo 'LDPATH=/usr/lib/oracle/10.1.0.2/client/lib' > ${D}/etc/env.d/50oracle-instantclient-basic

}

pkg_postinst() {
	echo
	einfo "The Basic client page for Oracle 10g has been installed."
	einfo "You may also wish to install the oracle-instantclient-jdbc (for"
	einfo "supplemental JDBC functionality with Oracle) and the"
	einfo "oracle-instantclient-sqlplus (for running the SQL*Plus application)"
	einfo "packages as well."
	echo
}
