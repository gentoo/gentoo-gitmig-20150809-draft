# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygame/pygame-1.6.ebuild,v 1.3 2004/02/26 19:41:01 bazik Exp $

inherit distutils

DESCRIPTION="python bindings to sdl and other libs that facilitate game production"
HOMEPAGE="http://www.pygame.org/"
SRC_URI="http://www.pygame.org/ftp/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 hppa sparc"

DEPEND="virtual/python
	>=media-libs/libsdl-1.2.5
	>=media-libs/sdl-ttf-2.0.6
	>=media-libs/sdl-image-1.2.2
	>=media-libs/sdl-mixer-1.2.4
	>=dev-python/numeric-22.0
	>=media-libs/smpeg-0.4.4-r1"


src_install () {
	mydoc=WHATSNEW
	distutils_src_install

	dohtml -r docs/*
	insinto /usr/share/doc/${PF}/examples
	doins ${S}/examples/*
	insinto /usr/share/doc/${PF}/examples/data
	doins ${S}/examples/data/*
}
