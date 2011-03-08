# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libva/libva-1.0.10.ebuild,v 1.1 2011/03/08 12:28:13 scarabeus Exp $

EAPI=4
inherit autotools-utils autotools

DESCRIPTION="Video Acceleration (VA) API for Linux"
HOMEPAGE="http://freedesktop.org/wiki/Software/vaapi/"
SRC_URI="http://cgit.freedesktop.org/libva/snapshot/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE="opengl"

VIDEO_CARDS="dummy nvidia intel" # fglrx
for x in ${VIDEO_CARDS}; do
	IUSE+=" video_cards_${x}"
done

RDEPEND=">=x11-libs/libdrm-2.4
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXfixes
	opengl? ( virtual/opengl )
	video_cards_intel? ( >=x11-libs/libdrm-2.4.23 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"
PDEPEND="video_cards_nvidia? ( x11-libs/vdpau-video )"

AUTOTOOLS_IN_SOURCE_BUILD=1

PATCHES=(
	"${FILESDIR}/${PN}-dont-install-tests.patch"
)

src_prepare() {
	autotools-utils_src_prepare
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		"--disable-static"
		$(use_enable video_cards_dummy dummy-driver)
		$(use_enable video_cards_intel i965-driver)
		$(use_enable opengl glx)
	)

	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	remove_libtool_files all
}
