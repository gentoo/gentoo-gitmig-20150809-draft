# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/spectemu/spectemu-0.9.4.ebuild,v 1.9 2004/03/21 19:24:46 dholm Exp $

IUSE="X readline svga"

DESCRIPTION="48k ZX Spectrum Emulator"
HOMEPAGE="http://kempelen.iit.bme.hu/~mszeredi/spectemu/spectemu.html"
LICENSE="GPL-2 | LGPL-2"
SRC_URI="http://home.gwi.net/~plemon/sources/spectemu-0.94.tar.gz"
KEYWORDS="x86 ~ppc"
SLOT="0"
### Several versions of specemu exist,  xspect & vgaspect, utilising X11
### and/or svgalib. libreadline provides optional runtime features.
### The ./configure script automagically figures out which binaries to build
### so the run/compiletime dependancies here are use dependant

DEPEND="X? ( x11-base/xfree )
	readline? ( sys-libs/readline )"
RDEPEND="svga? ( media-libs/svgalib )"

S=${WORKDIR}/spectemu-0.94/

src_compile() {

### First we'll set compiletime options for X11 & libreadline, there are no
### switches for svgalib, if its installed, it'll build vgaspect. if not,
### well... it wont!

	local myflags
	use X || myflags="${myflags} --with-x=no"
	use readline || myflags="${myflags} --without-readline"

### and no we'll configure & compile as appropriate

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man/man1 \
		${myflags} || die "Spectemu ./configure failed"
	make clean || die "Spectemu make clean failed"
	emake || die "Spectemu make failed"
}

src_install () {

### Here's our make install, nothing special here,  houston, we are
### go for launch.

	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man/man1 \
		infodir=${D}/usr/share/info \
		install || die "Spectemu make install failed"
}

