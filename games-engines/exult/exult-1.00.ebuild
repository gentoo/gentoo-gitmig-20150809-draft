# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/exult/exult-1.00.ebuild,v 1.4 2004/02/29 10:32:28 vapier Exp $

inherit games

DESCRIPTION="an Ultima 7 game engine that runs on modern operating systems"
HOMEPAGE="http://exult.sourceforge.net/"
SRC_URI="mirror://sourceforge/exult/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc"

RDEPEND=">=media-libs/libsdl-1.2*
	 >=media-sound/timidity++-2*"

pkg_setup() {
	ewarn "*********************************************************"
	ewarn " I had massive problems with exult when using agressive"
	ewarn " CFLAGS and CXXFLAGS. If exult segfaults try less"
	ewarn " agressive optimizations and/or a different -march"
	ewarn " e.g.: -march=i386 instead of -march=i686 on x86"
	ewarn "*********************************************************"
}

src_compile() {
	egamesconf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS FAQ README README.1ST
	prepgamesdirs
}

pkg_postinst() {
	einfo "To hear music in exult,"
	einfo "you have to install a timidity-patch."
	einfo "Try this:"
	einfo "		$ emerge timidity-eawpatches"
	einfo "kernel drivers. Install alsa instead."
	einfo
	einfo "You *must* have the original Ultima7 The Black Gate and/or"
	einfo "The Serpent Isle installed. "
	einfo "See /usr/doc/${PF}/README.gz for infos!"
}
