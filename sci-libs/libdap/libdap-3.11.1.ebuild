# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libdap/libdap-3.11.1.ebuild,v 1.1 2011/06/02 10:49:08 scarabeus Exp $

EAPI=4

inherit base

DESCRIPTION="Implementation of a C++ SDK for DAP 2.0 and 3.2"
HOMEPAGE="http://opendap.org/"
SRC_URI="http://www.opendap.org/pub/source/${P}.tar.gz"

LICENSE="|| ( LGPL-2.1 URI )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc"

RDEPEND="
	dev-util/cppunit
	dev-libs/libxml2:2
	net-misc/curl
	sys-libs/zlib
"

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

PATCHES=( "${FILESDIR}/3.10.0-fix_tests.patch" )

DOCS=( README NEWS README.dodsrc )

RESTRICT="test"
# needs http connection
# FAIL: MIMEUtilTest

src_configure() {
	econf \
		--disable-static
}

src_compile() {
	base_src_compile
	if use doc; then
		emake docs || die "make docs failed"
	fi
}

src_test() {
	cd "${S}"/unit-tests
	emake check || die
}

src_install() {
	default
	use doc && dohtml docs/html/*

	find "${ED}" -name '*.la' -exec rm -f {} +
}
