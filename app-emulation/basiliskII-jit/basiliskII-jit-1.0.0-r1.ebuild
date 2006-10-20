# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/basiliskII-jit/basiliskII-jit-1.0.0-r1.ebuild,v 1.6 2006/10/20 19:56:25 genstef Exp $

inherit flag-o-matic eutils

### This package requires a Mac II/Classic ROM, A Mac OS Image
### Mac OS 7.5.3r2 is available freely from the Apple Homepage
### System ROMS can be retreived from a 'real' Mac, See info/man pages

S="${WORKDIR}/BasiliskII-jit-1.0/src/Unix"
DESCRIPTION="Basilisk II/JIT Macintosh Emulator"
HOMEPAGE="http://gwenole.beauchesne.online.fr/basilisk2/"
SRC_URI="http://hometown.aol.de/wimdk/files/BasiliskII-jit-1.0-mdk-src.tar.bz2"

LICENSE="|| ( GPL-2 LGPL-2.1 )"
KEYWORDS="x86 -ppc"
SLOT="0"

IUSE="dga esd gtk nls sdl xv"

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
	!app-emulation/basiliskII"

DEPEND="${RDEPEND}
	!sdl? ( dga? ( x11-proto/xf86dgaproto ) )
	nls? ( sys-devel/gettext )
	x11-proto/xf86vidmodeproto
	x11-proto/xextproto
	x11-proto/xproto
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/basiliskII-jit-gcc34.patch

	# Fix up the vendor (bug 35352)
	sed -i \
		-e "s/Mandrake/Gentoo/g" ${S}/keycodes || \
			die "sed keycods failed"

	#prevent prestripped binary
	cd "${S}"
	sed -i -e '/^INSTALL_PROGRAM/s/-s//' Makefile.in
	
	if use sdl && use dga ; then
		einfo "SDL support was requested, DGA will be disabled"
	fi
}

src_compile() {
	#fpu_x86 doesnt compile properly if -O3 or greater :(
	replace-flags -O[3-9] -O2

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
	use xv || myflags="${myflags} --enable-xf86-vidmode=no"

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--enable-jit-compiler \
		${myflags} || die "./configure failed"

	#hack to link against libstdc++ for gcc3.x compatibility
	sed -i \
		-e 's:-o $(OBJ_DIR)/gencpu:-lstdc++ -o $(OBJ_DIR)/gencpu:' \
		Makefile || die "sed Makefile failed"

	emake -j1 || die "emake failed"
}

src_install() {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die "make install failed"

	mv ${D}/usr/bin/BasiliskII ${D}/usr/bin/BasiliskII-jit
	mv ${D}/usr/share/man/man1/BasiliskII.1 \
		${D}/usr/share/man/man1/BasiliskII-jit.1
	cd ../..
	dodoc ChangeLog README TECH TODO TODO.JIT

### Networking is _disabled_ in this revision,  hopefully -r2 will
### resolve the permissions issue / linux src compilation problem
### that prevents it's inclusion

### Uncomment the following, and read the manual _carefully_ if you really
### need networking, this will create a sheep_net.o kernel module that
### provides (effectivly) an ethernet bridge between basliskII and the kernel

#	make modules
}
