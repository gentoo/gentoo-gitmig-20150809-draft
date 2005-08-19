# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/osptoolkit/osptoolkit-3.3.1.ebuild,v 1.1 2005/08/19 19:29:22 stkn Exp $

DESCRIPTION="OSP (Open Settlement Protocol) library"
HOMEPAGE="http://www.transnexus.com/"
SRC_URI="http://www.transnexus.com/OSP%20Toolkit/Toolkits%20for%20Download/OSPToolkit-3.3.1.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND="virtual/libc
	dev-libs/openssl"

S=${WORKDIR}/TK-${PV//./_}-20041213_B

src_compile() {
	cd ${S}/src
	emake build || die "emake libosp failed"

	cd ${S}/enroll
	emake linux || die "emake enroll failed"

	cd ${S}/test
	emake linux || die "emake test failed"
}

src_install() {
	dodir /usr/{lib,include}

	cd ${S}/src
	make INSTALL_PATH=${D}/usr install || die "make install failed"

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
