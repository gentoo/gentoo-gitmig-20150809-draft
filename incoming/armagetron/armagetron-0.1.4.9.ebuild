# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Tom von Schwerdtner <tvon@etria.org>
#

S="${WORKDIR}/armagetron"
DESCRIPTION="A 3d lightcycle game"
SRC_URI="http://prdownloads.sourceforge.net/armagetron/armagetron_src_0.1.4.9.tar.gz"
HOMEPAGE="http://armagetron.sourceforge.net/"

DEPEND="virtual/x11
		virtual/opengl
		media-libs/libsdl
		media-libs/sdl-image
		media-libs/sdl-mixer
		sys-libs/zlib
		media-libs/libpng"

src_compile() {
	cd ${S}
	# the configure script is not as advanced as most and really does nothing
	# with the following options, but maybe someday it will......*shrug*
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake OPT="$CFLAGS" || die "make failed"
}

src_install () {
	# An extension to the comment above, there is no 'make install'
	exeinto /usr/share/armagetron
	doexe src/tron/armagetron
	insinto /usr/share/armagetron/sound
	doins sound/*
	insinto /usr/share/armagetron/textures
	doins textures/*
	insinto /usr/share/armagetron/models
	doins models/*
	dobin ${FILESDIR}/armagetron
	dodoc README README-SDL COPYING.txt 
}
