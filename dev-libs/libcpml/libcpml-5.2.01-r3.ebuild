# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libcpml/libcpml-5.2.01-r3.ebuild,v 1.7 2007/07/02 14:55:18 peper Exp $

inherit eutils rpm

HOMEPAGE="ftp://ftp.compaq.com/pub/products/linuxdevtools/latest/downloads.html"
DESCRIPTION="Compaq Linux optimized math library for Alpha/Linux/GNU"
SRC_URI="ev6? ( ftp://ftp.compaq.com/pub/products/linuxdevtools/latest/cpml_ev6-5.2.0-1.alpha.rpm )
	!ev6? ( ftp://ftp.compaq.com/pub/products/linuxdevtools/latest/cpml_ev5-5.2.0-1.alpha.rpm )"

LICENSE="compaq-sdla"
SLOT="5.2.01"
KEYWORDS="-* ~alpha"
IUSE="ev6"
RESTRICT="fetch strip mirror"

DEPEND="virtual/libc
	sys-devel/binutils
	dev-libs/libots
	sys-apps/findutils"
RDEPEND="virtual/libc
	dev-libs/libots"

S=${WORKDIR}/usr

src_unpack() {
	rpm_src_unpack
	find ${S} -type d -exec chmod a+rx {} \;
}

src_compile () {
	local EV; use ev6 && EV=ev6 || EV=ev5
	cd ${S}/lib/compaq/cpml-5.2.0
	ld ${LDFLAGS} -shared -o libcpml_${EV}.so -soname libcpml.so \
		-whole-archive libcpml_${EV}.a -no-whole-archive -lots
}

src_install() {
	local EV; use ev6 && EV=ev6 || EV=ev5

	mv ${WORKDIR}/usr ${D}

	dodir /usr/lib/
	dosym ./compaq/cpml-5.2.0/libcpml_${EV}.so /usr/lib/libcpml_${EV}.so
	dosym ./compaq/cpml-5.2.0/libcpml_${EV}.a /usr/lib/libcpml_${EV}.a

	dodir /usr/share
	mv ${D}/usr/doc ${D}/usr/share

	dosym ./compaq/cpml-5.2.0/libcpml_${EV}.so /usr/lib/libcpml.so
	dosym ./compaq/cpml-5.2.0/libcpml_${EV}.a /usr/lib/libcpml.a

}
