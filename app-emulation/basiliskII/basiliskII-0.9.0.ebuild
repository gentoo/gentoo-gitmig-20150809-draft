# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/basiliskII/basiliskII-0.9.0.ebuild,v 1.4 2002/08/19 17:57:04 cybersystem Exp $

### This package requires a Mac II/Classic ROM, A Mac OS Image
### Mac OS 7.5.3r2 is available freely from the Apple Homepage
### System ROMS can be retreived from a 'real' Mac, See info/man pages

DESCRIPTION="BasiliskII-0.9.0 Macintosh Emulator (Stable Release)"
HOMEPAGE="http://phcip1.phyzik.uni-mainz.de/~bauec002/B2Main.html"
LICENSE="GPL | LGPL"
KEYWORDS="x86 -ppc"
SLOT="0"

### We'll set $S Manually, it's version dependant, and nested strangely.
S=${WORKDIR}/BasiliskII-0.9/src/Unix

### fbdev support in the stable release...  the cvs branch is broken, period!
### gtk and esd support are compile time options, we'll check the usual
### use variables here and set ./configure options accordingly

DEPEND="gtk? ( x11-libs/gtk+ )
	esd? ( media-sound/esound )" 

RDEPEND="${DEPEND}"

SRC_URI="http://iphcip1.physik.uni-mainz.de/~cbauer/BasiliskII_src_31052001.tar.gz"

src_compile() {

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
		${myflags} || die "BasiliskII ./configure Failed"
	emake || die "BasiliskII Make Failed"
}

src_install () {
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
