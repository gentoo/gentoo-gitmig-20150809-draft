# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/ffmpeg/ffmpeg-0.6.ebuild,v 1.1 2011/03/23 13:41:40 scarabeus Exp $

EAPI=4

DESCRIPTION="Virtual package for FFmpeg implementation"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ~ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="X encode mp3 sdl theora threads vdpau x264"

DEPEND="
	|| (
		=media-video/libav-0.6*[X=,encode=,mp3=,sdl=,theora=,threads=,vdpau=,x264=]
		=media-video/ffmpeg-0.6*[X=,encode=,mp3=,sdl=,theora=,threads=,vdpau=,x264=]
	)
"
RDEPEND="${DEPEND}"
