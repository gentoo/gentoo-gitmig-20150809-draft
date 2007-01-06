# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/osptoolkit/osptoolkit-3.3.4.ebuild,v 1.4 2007/01/06 16:09:05 drizzt Exp $

inherit eutils

DESCRIPTION="OSP (Open Settlement Protocol) library"
HOMEPAGE="http://www.transnexus.com/"
SRC_URI="http://www.transnexus.com/OSP%20Toolkit/Toolkits%20for%20Download/OSPToolkit-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"

IUSE=""

RDEPEND="dev-libs/openssl"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/TK-${PV//./_}-20051103

src_unpack() {
	unpack ${A}

	cd "${S}"
	sed -i -e "s:\$(INSTALL_PATH)/lib:\$(INSTALL_PATH)/\$(LIBDIR):" \
		src/Makefile
}

src_compile() {
	emake -C src build || die "emake libosp failed"
	emake -C enroll linux || die "emake enroll failed"
	emake -C test linux || die "emake test failed"
}

src_install() {
	dodir /usr/include /usr/$(get_libdir)

	make -C src INSTALL_PATH="${D}"/usr LIBDIR=$(get_libdir) \
		install || die "make install failed"

	sed -i  -e "s:^\(OPENSSL_CONF\).*:\1=/etc/ssl/openssl.cnf:" \
		-e "s:^\(RANDFILE\).*:\1=/etc/ssl/.rnd:" \
		bin/enroll.sh

	dosbin bin/enroll*
	newbin bin/test_app osp_test_app

	dodoc *.txt

	insinto /usr/share/doc/${PF}
	doins bin/test.cfg
}

pkg_postinst() {
	elog "The OSP test application is located in ${ROOT}usr/bin/osp_test_app"
	elog "See ${ROOT}usr/share/doc/${PF}/test.cfg for a sample test.cfg for osp_test_app"
}
