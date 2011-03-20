# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/yoshimi/yoshimi-0.056.ebuild,v 1.3 2011/03/20 20:06:19 jlec Exp $

EAPI=2
inherit cmake-utils

DESCRIPTION="A software synthesizer based on ZynAddSubFX"
HOMEPAGE="http://yoshimi.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
# We can't be sure if SSE is available on x86 wrt bug #316627
KEYWORDS="~amd64 -x86"
IUSE=""

RDEPEND="
	sys-libs/zlib
	media-libs/fontconfig
	x11-libs/fltk:1
	=sci-libs/fftw-3*
	>=dev-libs/mini-xml-2.5
	>=media-libs/alsa-lib-1.0.17
	>=media-sound/jack-audio-connection-kit-0.115.6
	media-libs/libsndfile"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${P}/src

DOCS="../README.txt"

src_prepare() {
	sed -i \
		-e '/set(CMAKE_CXX_FLAGS_RELEASE/d' \
		CMakeLists.txt || die
}
