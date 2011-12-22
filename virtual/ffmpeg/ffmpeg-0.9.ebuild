# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/ffmpeg/ffmpeg-0.9.ebuild,v 1.2 2011/12/22 11:55:56 aballier Exp $

EAPI=4

DESCRIPTION="Virtual package for FFmpeg implementation"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86-fbsd"
IUSE="X +encode jpeg2k mp3 sdl theora threads vaapi vdpau x264"

RDEPEND="
	|| (
		>=media-video/ffmpeg-0.9[X=,encode=,jpeg2k=,mp3=,sdl=,theora=,threads=,vaapi=,vdpau=,x264=]
		>=media-video/libav-0.8_pre20111116[X=,encode=,jpeg2k=,mp3=,sdl=,theora=,threads=,vaapi=,vdpau=,x264=]
	)
"
DEPEND=""
