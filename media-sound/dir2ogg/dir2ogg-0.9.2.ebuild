# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/dir2ogg/dir2ogg-0.9.2.ebuild,v 1.4 2007/07/11 19:30:23 mr_bones_ Exp $

DESCRIPTION="Converts MP3, M4A, and WAV files to OGG format."
HOMEPAGE="http://badcomputer.org/linux/dir2ogg/"
SRC_URI="http://badcomputer.org/unix/dir2ogg/src/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND="virtual/python
	 dev-python/pyid3lib
	 media-libs/faad2
	 media-sound/vorbis-tools
	 || ( media-sound/mpg123 media-sound/mpg321 )"

src_install() {
	dobin dir2ogg
	doman dir2ogg.1
	dodoc README
}
