# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/dir2ogg/dir2ogg-0.11.8.ebuild,v 1.1 2009/09/14 07:35:44 ssuominen Exp $

EAPI=2
inherit versionator

MY_PR=$(get_version_component_range 1-2)

DESCRIPTION="Converts mp3, m4a, wma, and wav files to Ogg Vorbis format."
HOMEPAGE="http://jak-linux.org/projects/dir2ogg"
SRC_URI="http://jak-linux.org/projects/${PN}/${MY_PR}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="aac cdparanoia flac mp3 musepack wavpack wma"

RDEPEND=">=dev-lang/python-2.5
	dev-python/pyid3lib
	media-sound/vorbis-tools[ogg123]
	>=media-libs/mutagen-1.11
	aac? ( || ( media-libs/faad2
		media-video/mplayer ) )
	cdparanoia? ( media-sound/cdparanoia )
	flac? ( || ( media-libs/flac
		media-video/mplayer ) )
	mp3? ( || ( media-sound/mpg123
		media-sound/lame
		media-video/mplayer
		media-sound/mpg321 ) )
	musepack? ( || ( >=media-sound/musepack-tools-444
		media-video/mplayer ) )
	wavpack? ( || ( media-sound/wavpack
		media-video/mplayer ) )
	wma? ( media-video/mplayer )"
DEPEND=""

src_install() {
	dobin dir2ogg || die
	doman dir2ogg.1
	dodoc NEWS README
}
