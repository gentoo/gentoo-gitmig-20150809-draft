# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/transkode/transkode-0.7-r2.ebuild,v 1.5 2009/11/13 16:46:42 ssuominen Exp $

EAPI=1
ARTS_REQUIRED=never
inherit kde confutils

DESCRIPTION="transKode is a KDE frontend for various audio transcoding tools."
HOMEPAGE="http://kde-apps.org/content/show.php?content=37669"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="amd64 ~ppc x86"
IUSE="ffmpeg gstreamer mplayer wavpack xine"

RDEPEND="!${CATEGORY}/${PN}:0
	media-libs/taglib
	ffmpeg? ( media-video/ffmpeg )
	gstreamer? (
		>=media-libs/gstreamer-0.10
		>=media-libs/gst-plugins-good-0.10
		>=media-plugins/gst-plugins-flac-0.10
		>=media-plugins/gst-plugins-lame-0.10
		>=media-plugins/gst-plugins-vorbis-0.10
		>=media-plugins/gst-plugins-ogg-0.10
		>=media-plugins/gst-plugins-faad-0.10
		)
	mplayer? ( media-video/mplayer )
	wavpack? ( media-sound/wavpack )
	xine? ( media-sound/xineadump )"
DEPEND="${RDEPEND}"

need-kde 3.5

PATCHES=(
	"${FILESDIR}/${P}-gcc-4.3.patch"
	"${FILESDIR}/${P}-gcc-4.4.patch"
	"${FILESDIR}/${P}-desktop-file.diff"
	)

S="${WORKDIR}/${PN}"

pkg_setup() {
	kde_pkg_setup
	if ! use ffmpeg && ! use mplayer && ! use gstreamer && ! use xine ; then
		echo
		ewarn "TransKode should be emerged with at least one of next"
		ewarn "use flags: mplayer, ffmpeg, gstreamer or xine!"
		ewarn "None of them is mandatory but they install programs that"
		ewarn "can be used for decoding of audio formats for which no "
		ewarn "other decoder is present."
		echo
		ebeep
		epause 5
	fi
}

src_unpack() {
	kde_src_unpack
	rm -f "${S}"/configure
}

src_compile() {
	local myconf="--disable-amarokscript"
	kde_src_compile
}
