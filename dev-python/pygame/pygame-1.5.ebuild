# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygame/pygame-1.5.ebuild,v 1.1 2002/05/31 03:26:56 jnelson Exp $

S=${WORKDIR}/${P}
DESCRIPTION="python bindings to sdl and other libs that facilitate game production"
SRC_URI="http://www.pygame.org/ftp/${P}.tar.gz"
HOMEPAGE="http://www.pygame.org/"
LICENSE="LGPL-2.1"
SLOT="0"

DEPEND="virtual/python
	>=media-libs/libsdl-1.2.4
	>=media-libs/sdl-ttf-2.0.5
	>=media-libs/sdl-image-1.2.0
	>=media-libs/sdl-mixer-1.2.3
	>=dev-python/Numeric-21.0.0
	>=media-libs/smpeg-0.4.4-r1"
RDEPEND="${DEPEND}"

src_compile() {
	python setup.py build || die
}

src_install () {
	python setup.py install --root=${D} --prefix=/usr || die
	
	dodoc README.TXT WHATSNEW
	dohtml -r docs/*
	dodir /usr/share/doc/${PF}/examples
	cp -r ${S}/examples ${D}usr/share/doc/${PF}/examples
}

