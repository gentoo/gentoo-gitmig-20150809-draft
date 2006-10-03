# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/osptoolkit/osptoolkit-3.3.4.ebuild,v 1.2 2006/10/03 15:38:37 genstef Exp $

DESCRIPTION="OSP (Open Settlement Protocol) library"
HOMEPAGE="http://www.transnexus.com/"
SRC_URI="http://www.transnexus.com/OSP%20Toolkit/Toolkits%20for%20Download/OSPToolkit-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

RDEPEND="virtual/libc
	dev-libs/openssl"

DEPEND="${RDEPEND}"

S=${WORKDIR}/TK-${PV//./_}-20051103

src_unpack() {
	unpack ${A}

	cd ${S}
	sed -i -e "s:\$(INSTALL_PATH)/lib:\$(INSTALL_PATH)/\$(LIBDIR):" \
		src/Makefile
}

src_compile() {
	cd ${S}/src
	emake build || die "emake libosp failed"

	cd ${S}/enroll
	emake linux || die "emake enroll failed"

	cd ${S}/test
	emake linux || die "emake test failed"
}

src_install() {
	dodir /usr/include /usr/lib

	cd ${S}/src
	make INSTALL_PATH=${D}/usr LIBDIR=lib \
		install || die "make install failed"

	sed -i  -e "s:^\(OPENSSL_CONF\).*:\1=/etc/ssl/openssl.cnf:" \
		-e "s:^\(RANDFILE\).*:\1=/etc/ssl/.rnd:" \
		${S}/bin/enroll.sh

	dosbin ${S}/bin/enroll*
	newbin ${S}/bin/test_app osp_test_app

	cd ${S}
	dodoc *.txt

	insinto /usr/share/doc/${PF}
	doins bin/test.cfg
}

pkg_postinst() {
	einfo "The OSP test application is located in ${ROOT}usr/bin/osp_test_app"
	einfo "See ${ROOT}usr/share/doc/${PF}/test.cfg for a sample test.cfg for osp_test_app"
}
