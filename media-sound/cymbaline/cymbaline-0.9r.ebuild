# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/cymbaline/cymbaline-0.9r.ebuild,v 1.2 2003/04/24 13:32:23 phosphan Exp $

inherit eutils

DESCRIPTION="Smart Command Line Mp3 Player"
SRC_URI="http://www.silmarill.org/files/${P}.tar.gz"
HOMEPAGE="http://silmarill.org/cymbaline.htm"
IUSE="mikmod oggvorbis"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
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
	exeinto /usr/bin
	newexe cymbaline.py cymbaline
	insinto /usr/lib/cymbaline
	doins ID3.py mp3.py cycolors.py 
}

