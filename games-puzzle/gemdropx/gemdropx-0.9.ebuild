# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/gemdropx/gemdropx-0.9.ebuild,v 1.1 2003/09/10 06:36:00 vapier Exp $

DESCRIPTION="A puzzle game where it's your job to clear the screen of gems"
SRC_URI="ftp://ftp.sonic.net/pub/users/nbs/unix/x/gemdropx/${P}.tar.gz"
HOMEPAGE="http://www.newbreedsoftware.com/gemdropx/"
KEYWORDS="x86 ppc"
DEPEND=">=media-libs/libsdl-1.2.3-r1
	>=media-libs/sdl-mixer-1.2.1
	virtual/x11"
SLOT="0"
LICENSE="GPL-2"

src_compile() {
	emake DATA_PREFIX=/usr/share/gemdropx-data
}

src_install () {
	dodir /usr/share/gemdropx-data
	cp -a data/* ${D}/usr/share/gemdropx-data/
	dobin gemdropx
}
