# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/pstreams/pstreams-0.48.ebuild,v 1.1 2012/12/03 10:06:56 jlec Exp $

EAPI=5

inherit toolchain-funcs

DESCRIPTION="C++ wrapper for the POSIX.2 functions popen(3) and pclose(3)"
HOMEPAGE="http://pstreams.sourceforge.net/"
SRC_URI="
	mirror://sourceforge/${PN}/${P}.tar.gz
	doc? ( mirror://sourceforge/${PN}/${P}-docs.tar.gz )"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="LGPL-3"
IUSE="doc"

RDEPEND=""
DEPEND="doc? ( app-doc/doxygen )"

src_compile() {
	use doc && emake
}

src_test() {
	emake \
		CXX="$(tc-getCXX)" \
		CXXFLAGS="${CXXFLAGS}" \
		check
}

src_install() {
	insinto /usr/include
	doins pstream.h

	dodoc AUTHORS ChangeLog README

	use doc && dohtml -r "${WORKDIR}"/${PN}-docs-${PV}/* -R
}
