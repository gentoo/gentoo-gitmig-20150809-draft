# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/basiliskII/basiliskII-1.0.0_pre20050412.ebuild,v 1.3 2006/10/20 19:44:32 genstef Exp $

inherit flag-o-matic eutils

### This package requires a Mac II/Classic ROM, A Mac OS Image
### Mac OS 7.5.3r2 is available freely from the Apple Homepage
### System ROMS can be retreived from a 'real' Mac, See info/man pages

DESCRIPTION="Basilisk II Macintosh Emulator"
HOMEPAGE="http://www.uni-mainz.de/~bauec002/B2Main.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="|| ( GPL-2 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="dga esd gtk nls sdl"

### We'll set $S Manually, it's version dependant, and nested strangely.
S=${WORKDIR}/${P}/src/Unix

### fbdev support in the stable release...  the cvs branch is broken, period!
### gtk and esd support are compile time options, we'll check the usual
### use variables here and set ./configure options accordingly

RDEPEND="esd? ( media-sound/esound )
	gtk? ( =x11-libs/gtk+-1.2* gnome-base/libgnomeui )
	!sdl? ( dga? ( x11-libs/libXxf86dga ) )
	sdl? ( media-libs/libsdl )
	nls? ( virtual/libintl )
	x11-libs/libSM
	x11-libs/libXi
	x11-libs/libXxf86vm
	!app-emulation/basiliskII-jit"

DEPEND="${RDEPEND}
	!sdl? ( dga? ( x11-proto/xf86dgaproto ) )
	nls? ( sys-devel/gettext )
	x11-proto/xf86vidmodeproto
	x11-proto/xextproto
	x11-proto/xproto"


src_unpack() {
	unpack ${A}
	cd "${S}"
	#prevent prestripped binary
	sed -i -e '/^INSTALL_PROGRAM/s/-s//' Makefile.in
	
	if use sdl && use dga ; then
		einfo "SDL support was requested, DGA will be disabled"
	fi
}

src_compile() {
	#fpu_x86 doesnt compile properly if -O3 or greater :(
	replace-flags -O[3-9] -O2
	strip-flags -mpowerpc-gfxopt

	local myflags

### Default ./configure options are all =yes by default. we'll check for
### and use -values and switch them accordingly

	use esd || myflags="${myflags} --with-esd=no"
	use gtk || myflags="${myflags} --with-gtk=no"
	use dga || myflags="${myflags} --enable-xf86-dga=no"
	use nls || myflags="${myflags} --disable-nls"
	use sdl && myflags="${myflags} \
		--enable-sdl-video=yes \
		--enable-sdl-audio=yes"


	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myflags} || die "BasiliskII ./configure Failed"

	#hack to link against libstdc++ for gcc3.x compatibility
	sed -i -e 's:-o $(OBJ_DIR)/gencpu:-lstdc++ -o $(OBJ_DIR)/gencpu:' Makefile

	emake -j1 || die "BasiliskII Make Failed"
}

src_install() {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die "BasiliskII Make Install Failed"

### Networking is _disabled_ in this revision,  hopefully -r2 will
### resolve the permissions issue / linux src compilation problem
### that prevents it's inclusion

### Uncomment the following, and read the manual _carefully_ if you really
### need networking, this will create a sheep_net.o kernel module that
### provides (effectivly) an ethernet bridge between basliskII and the kernel

#	make modules
}
