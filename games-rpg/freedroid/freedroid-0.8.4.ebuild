# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/freedroid/freedroid-0.8.4.ebuild,v 1.1 2003/09/10 06:26:50 vapier Exp $

SRC_URI="mirror://sourceforge/freedroid/${P}.tar.gz"
HOMEPAGE="http://freedroid.sourceforge.net/"

LICENSE="GPL-2"

DESCRIPTION="Freedroid - a Paradroid clone"

KEYWORDS="x86 ppc"
S=${WORKDIR}/${P}

DEPEND=">=media-libs/libsdl-1.1.5
	media-libs/sdl-image"
SLOT="0"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
