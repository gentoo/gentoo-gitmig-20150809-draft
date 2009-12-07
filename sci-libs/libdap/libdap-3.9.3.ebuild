# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libdap/libdap-3.9.3.ebuild,v 1.1 2009/12/07 06:27:24 bicatali Exp $

EAPI=2
inherit autotools eutils flag-o-matic

DESCRIPTION="Implementation of a C++ SDK for DAP 2.0 and 3.2"
HOMEPAGE="http://opendap.org/"
SRC_URI="http://www.opendap.org/pub/source/${P}.tar.gz"

LICENSE="|| ( LGPL-2.1 URI )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc"

RDEPEND="dev-util/cppunit
	dev-util/dejagnu"

DEPEND="${RDEPEND}
	>=sys-libs/zlib-1.1.4
	>=dev-libs/libxml2-2.5.7
	>=net-misc/curl-7.12.0
	doc? ( app-doc/doxygen )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-3.9.2-gcc-4.4.patch
}

src_compile() {
	emake || die "emake failed"
	if use doc; then
		emake docs || die "make docs failed"
	fi
}

src_test() {
	cd "${S}"/unit-tests
	emake check
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README NEWS README.dodsrc README.AIS
	use doc && dohtml docs/html/*
}
