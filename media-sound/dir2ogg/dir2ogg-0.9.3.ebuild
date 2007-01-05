# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/dir2ogg/dir2ogg-0.9.3.ebuild,v 1.2 2007/01/05 17:28:17 flameeyes Exp $


DESCRIPTION="Converts Mp3, M4a, Wma, and Wav files to Ogg Vorbis format."
HOMEPAGE="http://badcomputer.org/unix/dir2ogg/"
SRC_URI="http://badcomputer.org/unix/dir2ogg/src/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="aac wma"

DEPEND=""
RDEPEND="virtual/python
	dev-python/pyid3lib
	media-sound/vorbis-tools
	media-sound/mpg123
	aac? ( media-libs/faad2 )
	wma? ( media-video/mplayer )"

src_install() {
	dobin dir2ogg
	doman dir2ogg.1
	dodoc README CHANGES
}
