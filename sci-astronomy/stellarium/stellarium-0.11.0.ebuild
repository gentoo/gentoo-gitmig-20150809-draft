# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/stellarium/stellarium-0.11.0.ebuild,v 1.3 2011/08/11 19:39:20 xarthisius Exp $

EAPI=2
inherit cmake-utils eutils

DESCRIPTION="Stellarium renders 3D photo-realistic skies in real time."
HOMEPAGE="http://www.stellarium.org/"
SRC_URI="mirror://sourceforge/stellarium/${P}.tar.gz
	stars? (
		mirror://sourceforge/stellarium/stars_4_1v0_0.cat
		mirror://sourceforge/stellarium/stars_5_2v0_0.cat
		mirror://sourceforge/stellarium/stars_6_2v0_0.cat
		mirror://sourceforge/stellarium/stars_7_2v0_0.cat
		mirror://sourceforge/stellarium/stars_8_2v0_0.cat
	)"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 ~x86"
IUSE="nls stars"
RESTRICT="test"

RDEPEND="virtual/opengl
	virtual/glu
	media-libs/libpng
	media-libs/freetype:2
	virtual/jpeg
	>=x11-libs/qt-core-4.6.0:4
	x11-libs/qt-gui:4
	x11-libs/qt-opengl:4
	x11-libs/qt-script:4
	x11-libs/qt-svg:4
	x11-libs/qt-test:4
	media-fonts/dejavu
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	dev-libs/boost
	>=dev-util/cmake-2.4.7
	nls? ( sys-devel/gettext )
	x11-libs/libXt"

src_configure() {
	mycmakeargs=( $(cmake-utils_use_enable nls NLS) )
	CMAKE_IN_SOURCE_BUILD=1 cmake-utils_src_configure
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	# use the more up-to-date system fonts
	rm -f "${D}"/usr/share/stellarium/data/DejaVuSans{Mono,}.ttf
	dosym /usr/share/fonts/dejavu/DejaVuSans.ttf /usr/share/stellarium/data/
	dosym /usr/share/fonts/dejavu/DejaVuSansMono.ttf /usr/share/stellarium/data/

	if use stars ; then
		insinto /usr/share/${PN}/stars/default
		doins "${DISTDIR}"/stars_[45678]_[12]v0_0*.cat || die "doins failed"
	fi
	newicon doc/images/stellarium-logo.png ${PN}.png
	make_desktop_entry ${PN} Stellarium ${PN} "Education;Science;Astronomy"
	dodoc AUTHORS ChangeLog README
}
