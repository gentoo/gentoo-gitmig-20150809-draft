# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Phillip Lemon (AITD) <plemon@gwi.net>
# $Header: /var/cvsroot/gentoo-x86/app-emulation/dosemu/dosemu-1.1.3.ebuild,v 1.1 2002/05/18 20:14:45 rphillips Exp $
S=${WORKDIR}/${P}

DESCRIPTION="DOSEmu 1.1.3 (Developer)"
SRC_URI="http://telia.dl.sourceforge.net/sourceforge/dosemu/dosemu-freedos-bin.tgz
         http://telia.dl.sourceforge.net/sourceforge/dosemu/dosemu-1.1.3.tgz"
HOMEPAGE="http://www.dosemu.org"
LICENSE="GPL | LGPL"
DEPEND="X? ( virtual/x11 )
		svga? ( media-libs/svgalib )"
	
src_compile() {

### We make base-configure executable here, so that we can pretend its our
### ./configure script, by passing it cli arguments, we bypass the usual
### DOSemu installation script routines :)

	chmod +x $S/base-configure	

	local myflags

### mitshm will bork ./base-configure entirely, so we disable it here	
	myflags="--enable-mitshm=no"

### and then set build paramaters based on USE variables
	use X || myflags="${myflags} --with-x=no"
	use svga && myflags="${myflags} --enable-use-svgalib"

### this is really a ./configure (honestly)
	./base-configure \
	--prefix=/usr \
	--infodir=/usr/share/info \
	--mandir=/usr/share/men \
	${myflags} || die "DOSemu Base Configuration Failed"
	
### We HAVE to do this, or the build will fail due to strange additional
### files in the downloaded tarball!
	make pristine || die "Dosemu Make Pristine Failed"

### Ok, the build tree is clean, lets make the executables, and 'dos' commands
	make -C src || die "DOSemu Make Failed!"
	make dosbin || die "DOSbin Make Failed"

}

src_install () {

### There is no 'make install' for DOSemu, just a set of install scripts
### We'll pass our portage image directory as the fs root, and 'install'
### as normal, this seems to stick with the usual gentoo standards

	./install_systemwide -fd /usr/portage/distfiles/dosemu-freedos-bin.tgz -r /var/tmp/portage/${PF}/image

}
