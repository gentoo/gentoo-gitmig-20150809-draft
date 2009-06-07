# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/dir2ogg/dir2ogg-0.11.6.ebuild,v 1.2 2009/06/07 21:20:08 maekke Exp $

inherit versionator

MY_PR=$(get_version_component_range 1-2)

DESCRIPTION="Converts mp3, m4a, wma, and wav files to Ogg Vorbis format."
HOMEPAGE="http://jak-linux.org/projects/dir2ogg"
SRC_URI="http://jak-linux.org/projects/${PN}/${MY_PR}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE="aac cdparanoia mp3 wma"

DEPEND=""
RDEPEND="dev-lang/python
	dev-python/pyid3lib
	media-sound/vorbis-tools
	>=media-libs/mutagen-1.11
	aac? ( media-libs/faad2 media-video/mplayer )
	cdparanoia? ( media-sound/cdparanoia )
	mp3? ( || ( media-sound/lame
		virtual/mpg123
		media-video/mplayer ) )
	wma? ( media-video/mplayer )"

src_install() {
	dobin ${PN} || die "dobin failed."
	doman ${PN}.1
	dodoc NEWS README
}
