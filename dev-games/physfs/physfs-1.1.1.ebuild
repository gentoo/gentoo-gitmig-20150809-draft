# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/physfs/physfs-1.1.1.ebuild,v 1.1 2007/08/27 00:54:43 mr_bones_ Exp $

DESCRIPTION="abstraction layer for filesystems, useful for games"
HOMEPAGE="http://icculus.org/physfs/"
SRC_URI="http://icculus.org/physfs/downloads/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="-* ~x86-fbsd"
IUSE="doc"

RDEPEND="sys-libs/zlib"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.4
	doc? ( app-doc/doxygen )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/test_physfs/d' \
		CMakeLists.txt \
		|| die "sed failed"
}

src_compile() {
	cmake -DCMAKE_INSTALL_PREFIX=/usr .
	emake || die
	if use doc ; then
		doxygen
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	if use doc ; then
		dohtml -r docs/html
	fi
	dodoc CHANGELOG.txt CREDITS.txt TODO.txt
}
