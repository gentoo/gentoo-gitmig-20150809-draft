# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/sdlroids/sdlroids-1.3.4-r1.ebuild,v 1.3 2004/01/24 12:48:12 mr_bones_ Exp $

DESCRIPTION="Asteroids Clone for X using SDL"
SRC_URI="mirror://sourceforge/sdlroids/${P}.tar.gz"
RESTRICT="nomirror"
HOMEPAGE="http://david.hedbor.org/projects/sdlroids/"
KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
DEPEND=">=media-libs/libsdl-1.1.8"

src_compile() {
	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --datadir=/usr/share
	assert

	emake || die
}

src_install () {
	make prefix=${D}/usr						\
	     datadir=${D}/usr/share					\
	     install || die

	dodoc COPYING ChangeLog README.orig README.* TODO
}
