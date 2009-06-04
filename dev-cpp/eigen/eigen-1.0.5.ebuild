# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/eigen/eigen-1.0.5.ebuild,v 1.5 2009/06/04 10:26:04 scarabeus Exp $

inherit toolchain-funcs

DESCRIPTION="Lightweight C++ template library for vector and matrix math, a.k.a. linear algebra"
HOMEPAGE="http://eigen.tuxfamily.org/"
SRC_URI="http://download.tuxfamily.org/${PN}/${P}.tar.gz"

LICENSE="GPL-2-with-exceptions"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND=">=dev-util/cmake-2.4.5"
RDEPEND=""

S=${WORKDIR}/${PN}

src_compile() {
	cmake -DCMAKE_INSTALL_PREFIX=/usr \
		-DCMAKE_C_COMPILER=$(type -p $(tc-getCC)) \
		-DCMAKE_CXX_COMPILER=$(type -p $(tc-getCXX)) || die "cmake failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	# Install the LICENSE file to make the specific GPL exception obvious.
	dodoc README TODO
}
