# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygame/pygame-1.4.ebuild,v 1.3 2002/07/30 00:50:10 george Exp $

S=${WORKDIR}/${P}
DESCRIPTION="python bindings to sdl and other libs that facilitate game production"
SRC_URI="http://www.pygame.org/ftp/${P}.tar.gz"
HOMEPAGE="http://www.pygame.org/"

# NOTES: sdl-image has been updated upstream to 1.2.2 as of
# this writing.

DEPEND="virtual/python
	>=media-libs/libsdl-1.2.4
	>=media-libs/sdl-ttf-2.0.5
	>=media-libs/sdl-image-1.2.0
	>=media-libs/sdl-mixer-1.2.3
	>=dev-python/Numeric-21.0.0
	>=media-libs/smpeg-0.4.4-r1"
RDEPEND="${DEPEND}"

SLOT="0"
KEYWORDS="x86"
LICENSE="LGPL-2.1"

src_unpack() {
	unpack ${A} && cd ${S} || die
	mv config_unix.py config_unix.py.orig || die
	# the smpeg library header is installed in /usr/include/smpeg
	# The package expects it in /usr/include/SDL
	# Note sure which is correct, but the following allows the
	# ebuild to work with either.
	sed -e 's:incdirs = \[\]:incdirs = \["/usr/include/smpeg"\]:g' config_unix.py.orig > config_unix.py || die
	# Patch mixer.c and music.c to not conflict with the 'pause' library call
	# Note that the next version won't need these, as CVS pygame
	# has an equivalent patch
	patch -p1 < ${FILESDIR}/mixer.c-pause.patch || die
	patch -p1 < ${FILESDIR}/music.c-pause.patch || die
}

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

