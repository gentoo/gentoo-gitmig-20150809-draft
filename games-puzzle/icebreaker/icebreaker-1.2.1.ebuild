# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/icebreaker/icebreaker-1.2.1.ebuild,v 1.1 2003/09/10 06:36:00 vapier Exp $

DESCRIPTION="Trap and capture penguins on Antarctica"
HOMEPAGE="http://www.mattdm.org/icebreaker/"
SRC_URI="http://www.mattdm.org/icebreaker/1.2.x/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="virtual/x11
	>=media-libs/libsdl-1.1.5
	>=media-libs/sdl-mixer-1.2.1"

src_compile() {
	emake prefix=/usr || die
}

src_install() {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		highscoredir=${D}/var/lib/games \
		install || die

	dodoc ChangeLog INSTALL LICENSE README* TODO
}
