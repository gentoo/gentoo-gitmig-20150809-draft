# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/ffmpeg/ffmpeg-0.6.90.ebuild,v 1.3 2011/05/06 23:36:44 sping Exp $

EAPI=4

DESCRIPTION="Virtual package for FFmpeg implementation"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="X +encode jpeg2k mp3 sdl theora threads vaapi vdpau x264"

RDEPEND="
	|| (
		>=media-video/ffmpeg-0.6.90_rc0-r2[X=,encode=,jpeg2k=,mp3=,sdl=,theora=,threads=,vaapi=,vdpau=,x264=]
		>=media-video/libav-0.6.90_rc[X=,encode=,jpeg2k=,mp3=,sdl=,theora=,threads=,vaapi=,vdpau=,x264=]
	)
"
DEPEND=""
