# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cymbaline/cymbaline-0.9r.ebuild,v 1.4 2003/09/07 00:06:04 msterret Exp $

inherit eutils

DESCRIPTION="Smart Command Line Mp3 Player"
HOMEPAGE="http://silmarill.org/cymbaline.htm"
SRC_URI="http://www.silmarill.org/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="mikmod oggvorbis"
RESTRICT="nostrip"

DEPEND="dev-lang/python
	media-sound/mpg123
	media-sound/aumix
	mikmod? ( media-sound/mikmod )
	oggvorbis? ( media-sound/vorbis-tools ) "

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}.patch
}

src_compile() {
	einfo No compilation necessary.
}

src_install () {
	dodir /usr/lib/cymbaline
	newbin cymbaline.py cymbaline
	insinto /usr/lib/cymbaline
	doins ID3.py mp3.py cycolors.py
}
