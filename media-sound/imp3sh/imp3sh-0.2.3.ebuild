# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/imp3sh/imp3sh-0.2.3.ebuild,v 1.2 2003/06/12 21:00:10 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="flexible playlist manipulation shell and song player/streamer"
SRC_URI="http://www.geocities.com/kman_can/${P}.tar.gz"
HOMEPAGE="http://www.geocities.com/kman_can/"
LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

IUSE=""

DEPEND="sys-libs/ncurses
		oggvorbis? ( media-libs/libvorbis
					 media-libs/libogg
					 media-libs/libao )"
RDEPEND=""


src_compile() {

	econf || die
	emake || die
	
}

src_install () {

	make DESTDIR=${D} install || die
	dodoc README* CHANGES web/README.imp3web web/imp3web.php EXAMPLE.imp3sh EXTERNAL.players
	# Some docs are liner notes in the actual .c files. UHG.
	dodoc piped-io/imp3sh*.c
}
