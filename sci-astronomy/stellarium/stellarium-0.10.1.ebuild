# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/stellarium/stellarium-0.10.1.ebuild,v 1.1 2009/02/06 23:07:11 mr_bones_ Exp $

EAPI=2
inherit cmake-utils eutils

DESCRIPTION="Stellarium renders 3D photo-realistic skies in real time."
HOMEPAGE="http://www.stellarium.org/"
SRC_URI="mirror://sourceforge/stellarium/${P}.tar.gz"

LICENSE="GPL-2 BitstreamVera"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="nls"

RDEPEND="virtual/opengl
	virtual/glu
	media-libs/libpng
	media-libs/freetype:2
	dev-libs/boost
	media-libs/jpeg
	|| ( ( x11-libs/qt-core:4 x11-libs/qt-gui:4 x11-libs/qt-script:4 x11-libs/qt-opengl:4 )  >=x11-libs/qt-4.4.2:4[opengl] )
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.4.7
	nls? ( sys-devel/gettext )
	x11-libs/libXt"

src_configure() {
	mycmakeargs=$(cmake-utils_use_enable nls NLS)
	cmake-utils_src_configurein
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	newicon doc/images/stellarium-logo.png ${PN}.png
	make_desktop_entry ${PN} Stellarium ${PN} "Education;Science;Astronomy;"
	dodoc AUTHORS ChangeLog README
}
