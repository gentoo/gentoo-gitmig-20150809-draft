# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/ffmpeg/ffmpeg-0.10.3.ebuild,v 1.4 2012/06/03 13:57:45 blueness Exp $

EAPI=4

DESCRIPTION="Virtual package for FFmpeg implementation"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~mips ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE="X +encode jpeg2k mp3 sdl theora threads truetype vaapi vdpau x264"

RDEPEND="
	|| (
		>=media-video/ffmpeg-0.10.3[X?,encode?,jpeg2k?,mp3?,sdl?,theora?,threads?,truetype?,vaapi?,vdpau?,x264?]
		>=media-video/libav-0.8.2-r2[X?,encode?,jpeg2k?,mp3?,sdl?,theora?,threads?,truetype?,vaapi?,vdpau?,x264?]
	)
"
DEPEND=""
