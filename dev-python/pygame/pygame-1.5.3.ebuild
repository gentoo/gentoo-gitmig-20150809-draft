# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygame/pygame-1.5.3.ebuild,v 1.15 2004/06/25 03:16:56 agriffis Exp $

DESCRIPTION="python bindings to sdl and other libs that facilitate game production"
SRC_URI="http://www.pygame.org/ftp/${P}.tar.gz"
HOMEPAGE="http://www.pygame.org/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 sparc alpha"
IUSE=""

DEPEND="virtual/python
	>=media-libs/libsdl-1.2.4
	>=media-libs/sdl-ttf-2.0.5
	>=media-libs/sdl-image-1.2.0
	>=media-libs/sdl-mixer-1.2.3
	>=dev-python/numeric-21.0*
	>=media-libs/smpeg-0.4.4-r1"

inherit distutils

src_install () {
	mydoc=WHATSNEW
	distutils_src_install

	dohtml -r docs/*
	dodir /usr/share/doc/${PF}/examples
	cp -r ${S}/examples ${D}usr/share/doc/${PF}/
}

