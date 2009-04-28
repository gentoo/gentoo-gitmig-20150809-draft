# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kwave/kwave-0.8.2.ebuild,v 1.2 2009/04/28 19:44:45 scarabeus Exp $

EAPI="2"

KDE_LINGUAS="cs de en fr"
inherit kde4-base

DESCRIPTION="Kwave is a sound editor for KDE."
HOMEPAGE="http://kwave.sourceforge.net/"
SRC_URI="mirror://sourceforge/kwave/${P}-1.tar.bz2"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="alsa debug doc flac mp3 ogg oss mmx"

RDEPEND="
	!media-sound/kwave:0
	media-libs/audiofile
	sci-libs/fftw
	alsa? ( media-libs/alsa-lib )
	flac? ( media-libs/flac )
	mp3? ( media-libs/id3lib media-libs/libmad )
	ogg? ( media-libs/libogg media-libs/libvorbis )
"

DEPEND="${RDEPEND}
	>=kde-base/kdesdk-misc-${KDE_MINIMAL}
	media-gfx/imagemagick"

PATCHES=( "${PV}-fix_gettext.patch" )
	
src_configure() {
	use mmx && append-flags "-mmmx"
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with alsa)
		$(cmake-utils_use_with doc)
		$(cmake-utils_use_with flac)
		$(cmake-utils_use_with mp3)
		$(cmake-utils_use_with ogg)
		$(cmake-utils_use_with oss)
		$(cmake-utils_use debug)
	"
	kde4-base_src_configure
}
