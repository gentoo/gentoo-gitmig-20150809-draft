# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/stellarium/stellarium-0.9.0.ebuild,v 1.1 2007/07/21 00:01:52 mr_bones_ Exp $

inherit toolchain-funcs eutils

DESCRIPTION="Stellarium renders 3D photo-realistic skies in real time."
HOMEPAGE="http://www.stellarium.org/"
SRC_URI="mirror://sourceforge/stellarium/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls"

RDEPEND="virtual/opengl
	virtual/glu
	media-libs/libpng
	media-libs/freetype
	dev-libs/boost
	media-libs/jpeg
	net-misc/curl
	=x11-libs/qt-4*
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.4.6
	nls? ( sys-devel/gettext )
	x11-libs/libXt"

src_unpack() {
	unpack ${A}
	cd "${S}"
	if ! use nls ; then
		sed -i \
			-e 's/ENABLE_NLS 1/ENABLE_NLS 0/' \
			CMakeLists.txt \
			|| die "sed failed"
	fi
}

src_compile() {
	CC=$(tc-getCC) \
	CXX=$(tc-getCXX) \
	cmake \
		-DCMAKE_INSTALL_PREFIX=/usr \
		|| die "cmake failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	use nls || rm -rf "${D}/usr/share/locale"
	make_desktop_entry stellarium Stellarium
	dodoc AUTHORS ChangeLog README TODO
}
