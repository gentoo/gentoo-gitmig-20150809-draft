# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/ffmpeg/ffmpeg-0.9.ebuild,v 1.3 2012/01/26 13:25:27 ssuominen Exp $

EAPI=4

DESCRIPTION="Virtual package for FFmpeg implementation"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86-fbsd"
IUSE="X +encode jpeg2k mp3 sdl theora threads vaapi vdpau x264"

RDEPEND="
	|| (
		>=media-video/ffmpeg-0.9[X=,encode=,jpeg2k=,mp3=,sdl=,theora=,threads=,vaapi=,vdpau=,x264=]
		>=media-video/libav-0.8_pre20111116[X=,encode=,jpeg2k=,mp3=,sdl=,theora=,threads=,vaapi=,vdpau=,x264=]
	)
"
DEPEND=""
