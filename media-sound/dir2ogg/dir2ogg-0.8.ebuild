# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/dir2ogg/dir2ogg-0.8.ebuild,v 1.5 2006/05/03 17:47:51 blubb Exp $

S=${WORKDIR}/${PN}

DESCRIPTION="Converts MP3, M4A, and WAV files to OGG format."
HOMEPAGE="http://badcomputer.no-ip.com/linux/dir2ogg/"
SRC_URI="http://badcomputer.no-ip.com/linux/dir2ogg/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 sparc x86"
IUSE=""

DEPEND=""
RDEPEND="virtual/python
	 dev-python/pyid3lib
	 media-sound/vorbis-tools
	 media-sound/mpg123
	 media-libs/faad2"

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	dobin dir2ogg
	doman dir2ogg.1
	dodoc README
}
