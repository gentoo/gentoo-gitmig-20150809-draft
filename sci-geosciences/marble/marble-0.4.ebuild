# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/marble/marble-0.4.ebuild,v 1.3 2008/04/09 18:06:48 ingmar Exp $

EAPI="1"
inherit toolchain-funcs multilib

DESCRIPTION="Free 3D desk globe and world atlas"
HOMEPAGE="http://edu.kde.org/marble/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	|| ( ( x11-libs/qt-gui:4
		x11-libs/qt-svg:4 )
			>=x11-libs/qt-4.2.3:4 )"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.4.5"

S=${WORKDIR}/${PN}

src_compile() {
	# Determine the lib suffix
	if [[ $(get_libdir) == 'lib64' ]]; then
		local libsuffix='64'
	else
		local libsuffix=''
	fi

	# Only use Qt to build marble
	cmake -DQTONLY=ON -DCMAKE_INSTALL_PREFIX=/usr \
		-DLIB_SUFFIX=${libsuffix} \
		-DCMAKE_C_COMPILER=$(type -p $(tc-getCC)) \
		-DCMAKE_CXX_COMPILER=$(type -p $(tc-getCXX))
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
}
