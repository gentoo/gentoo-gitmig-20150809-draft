# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/stellarium/stellarium-0.10.2.ebuild,v 1.4 2009/06/25 20:34:32 mr_bones_ Exp $

EAPI=2
inherit cmake-utils eutils

DESCRIPTION="Stellarium renders 3D photo-realistic skies in real time."
HOMEPAGE="http://www.stellarium.org/"
SRC_URI="mirror://sourceforge/stellarium/${P}.tar.gz"

LICENSE="GPL-2 BitstreamVera"
SLOT="0"
KEYWORDS="~amd64 ~ppc ppc64 ~x86"
IUSE="nls"
RESTRICT="test"

RDEPEND="virtual/opengl
	virtual/glu
	media-libs/libpng
	media-libs/freetype:2
	dev-libs/boost
	media-libs/jpeg
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-script:4
	x11-libs/qt-opengl:4
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.4.7
	nls? ( sys-devel/gettext )
	x11-libs/libXt"

src_configure() {
	mycmakeargs=$(cmake-utils_use_enable nls NLS)
	CMAKE_IN_SOURCE_BUILD=1 cmake-utils_src_configure
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	newicon doc/images/stellarium-logo.png ${PN}.png
	make_desktop_entry ${PN} Stellarium ${PN} "Education;Science;Astronomy;"
	dodoc AUTHORS ChangeLog README
}
