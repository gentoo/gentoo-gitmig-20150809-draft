# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/transkode/transkode-0.7-r2.ebuild,v 1.1 2009/05/26 09:05:58 scarabeus Exp $

EAPI="1"

ARTS_REQUIRED="never"
inherit kde confutils

DESCRIPTION="transKode is a KDE frontend for various audio transcoding tools."
HOMEPAGE="http://kde-apps.org/content/show.php?content=37669"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="amarok ffmpeg gstreamer mplayer wavpack xine"

RDEPEND="!${CATEGORY}/${PN}:0
	media-libs/taglib
	amarok? ( media-sound/amarok:3.5 )
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
	"${FILESDIR}/transkode-0.7-desktop-file.diff"
	)

S="${WORKDIR}/${PN}"

pkg_setup() {
	kde_pkg_setup
	confutils_require_built_with_any ffmpeg mplayer gstreamer xine
}

src_unpack() {
	kde_src_unpack
	rm -f "${S}"/configure
}

src_compile() {
	local myconf="$(use_enable amarok amarokscript)"
	kde_src_compile
}

pkg_postinst() {
	kde_pkg_postinst

	if use amarok; then
		elog "If you want to use TransKode to encode audio files on the fly"
		elog "when transferring music to a portable media device, remember"
		elog "to start the TransKode script through the Script Manager"
		elog "on the Tools menu."
	fi
}
