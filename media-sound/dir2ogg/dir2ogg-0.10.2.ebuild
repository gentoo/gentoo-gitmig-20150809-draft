# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/dir2ogg/dir2ogg-0.10.2.ebuild,v 1.4 2007/08/25 18:33:47 beandog Exp $

DESCRIPTION="Converts Mp3, M4a, Wma, and Wav files to Ogg Vorbis format."
HOMEPAGE="http://jak-linux.org/projects/dir2ogg"
SRC_URI="http://jak-linux.org/projects/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc ~x86"
IUSE="aac wma"

DEPEND=""
RDEPEND="virtual/python
	dev-python/pyid3lib
	media-sound/vorbis-tools
	media-libs/mutagen
	|| ( media-sound/mpg321 media-sound/mpg123 )
	aac? ( media-libs/faad2 )
	wma? ( media-video/mplayer )"

src_install() {
	dobin dir2ogg
	doman dir2ogg.1
	dodoc NEWS README
}
