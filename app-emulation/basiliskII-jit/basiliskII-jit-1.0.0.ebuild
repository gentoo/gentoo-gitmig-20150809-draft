# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/basiliskII-jit/basiliskII-jit-1.0.0.ebuild,v 1.2 2004/03/21 15:58:03 dholm Exp $

inherit flag-o-matic

### This package requires a Mac II/Classic ROM, A Mac OS Image
### Mac OS 7.5.3r2 is available freely from the Apple Homepage
### System ROMS can be retreived from a 'real' Mac, See info/man pages

S="${WORKDIR}/BasiliskII-jit-1.0/src/Unix"
DESCRIPTION="Basilisk II/JIT Macintosh Emulator"
HOMEPAGE="http://gwenole.beauchesne.online.fr/basilisk2/"
SRC_URI="http://hometown.aol.de/wimdk/files/BasiliskII-jit-1.0-mdk-src.tar.bz2"

LICENSE="GPL-2 | LGPL-2.1"
KEYWORDS="x86 -ppc"
SLOT="0"

IUSE="X gtk xv esd dga"

### fbdev support in the stable release...  the cvs branch is broken, period!
### gtk and esd support are compile time options, we'll check the usual
### use variables here and set ./configure options accordingly

DEPEND="gtk? ( x11-libs/gtk+ )
	esd? ( media-sound/esound )
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}

	# Fix up the vendor (bug 35352)
	sed -i \
		-e "s/Mandrake/Gentoo/g" ${S}/keycodes || \
			die "sed keycods failed"
}

src_compile() {
	#fpu_x86 doesnt compile properly if -O3 or greater :(
	replace-flags -O[3-9] -O2

	local myflags

### Default ./configure options are all =yes by default. we'll check for
### and use -values and switch them accordingly

	use X || myflags="${myflags} --with-x=no"
	use esd || myflags="${myflags} --with-esd=no"
	use gtk || myflags="${myflags} --with-gtk=no"
	use dga || myflags="${myflags} --with-dga=no"
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

	emake || die "emake failed"
}

src_install() {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die "make install failed"

	cd ../..
	dodoc ChangeLog INSTALL README TECH TODO TODO.JIT

### Networking is _disabled_ in this revision,  hopefully -r2 will
### resolve the permissions issue / linux src compilation problem
### that prevents it's inclusion

### Uncomment the following, and read the manual _carefully_ if you really
### need networking, this will create a sheep_net.o kernel module that
### provides (effectivly) an ethernet bridge between basliskII and the kernel

#	make modules
}
