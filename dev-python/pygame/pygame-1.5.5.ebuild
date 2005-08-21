# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygame/pygame-1.5.5.ebuild,v 1.11 2005/08/21 17:23:00 fserb Exp $

inherit distutils

DESCRIPTION="python bindings to sdl and other libs that facilitate game production"
SRC_URI="http://www.pygame.org/ftp/${P}.tar.gz"
HOMEPAGE="http://www.pygame.org/"

IUSE=""
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~sparc ~alpha"

DEPEND="virtual/python
	>=media-libs/libsdl-1.2.5
	>=media-libs/sdl-ttf-2.0.5
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

