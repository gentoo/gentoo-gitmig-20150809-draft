# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/pstreams/pstreams-0.7.0.ebuild,v 1.1 2010/05/18 20:31:41 jlec Exp $

inherit toolchain-funcs

DESCRIPTION="C++ wrapper for the POSIX.2 functions popen(3) and pclose(3)"
HOMEPAGE="http://pstreams.sourceforge.net/"
SRC_URI="
	mirror://sourceforge/${PN}/${P}.tar.gz
	doc? ( mirror://sourceforge/${PN}/${PN}-docs-${PV}.tar.gz )"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="LGPL-3"
IUSE="doc"

RDEPEND=""
DEPEND="doc? ( app-doc/doxygen )"

src_compile() {
	if use doc; then
		emake || die
	fi
}

src_test() {
	emake \
		CXX="$(tc-getCXX)" \
		CXXFLAGS="${CXXFLAGS}" \
		check
}

src_install() {
	insinto /usr/include
	doins pstream.h || die

	dodoc AUTHORS ChangeLog README || die

	if use doc; then
		dohtml -r "${WORKDIR}"/${PN}-docs-${PV}/* -R
	fi
}
