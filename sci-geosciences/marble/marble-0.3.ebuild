# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/marble/marble-0.3.ebuild,v 1.2 2007/04/05 00:44:01 cryos Exp $

inherit toolchain-funcs

DESCRIPTION="Free 3D desk globe and world atlas"
HOMEPAGE="http://edu.kde.org/marble/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=x11-libs/qt-4.2.3"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.4.5"

S=${WORKDIR}/${PN}

src_compile() {
	# Only use Qt to build marble
	cmake -DQTONLY=ON -DCMAKE_INSTALL_PREFIX=/usr \
		-DCMAKE_C_COMPILER=$(type -p $(tc-getCC)) \
		-DCMAKE_CXX_COMPILER=$(type -p $(tc-getCXX))
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
}
