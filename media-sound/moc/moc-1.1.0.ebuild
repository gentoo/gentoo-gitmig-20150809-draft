# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/gentoo-x86/media-sound/moc/moc-1.1.0.ebuild

IUSE="oggvorbis"

S=${WORKDIR}/${P}
DESCRIPTION="Music On Console - ncurses interface for playing audio files"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://moc.daper.net/"

DEPEND="media-libs/libao
        sys-libs/ncurses"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

src_compile() {
	local myconf
	use oggvorbis || myconf="--without-ogg"

	econf ${myconf} || die
	emake || die
}

src_install () {
	einstall || die
}
