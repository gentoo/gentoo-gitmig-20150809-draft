# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/imp3sh/imp3sh-0.2.4.ebuild,v 1.2 2009/05/08 18:55:50 gentoofan23 Exp $

inherit gnuconfig toolchain-funcs

DESCRIPTION="flexible playlist manipulation shell and song player/streamer"
HOMEPAGE="http://www.geocities.com/kman_can/"
SRC_URI="http://www.geocities.com/kman_can/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE=""

DEPEND="sys-libs/ncurses
	media-libs/libvorbis
	media-libs/libogg
	media-libs/libao"

src_unpack() {
	unpack ${A}
	cd "${S}"

	gnuconfig_update
}

src_compile() {
	econf
	emake CCLD=$(tc-getCXX) || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README* CHANGES web/README.imp3web web/imp3web.php EXAMPLE.imp3sh EXTERNAL.players
	# Some docs are liner notes in the actual .c files. UHG.
	dodoc piped-io/imp3sh*.c
}
