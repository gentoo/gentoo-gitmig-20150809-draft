# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-emulation/dosemu/dosemu-1.1.3-r1.ebuild,v 1.5 2002/08/06 19:02:36 gerk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="DOS Emulator"
SRC_URI="http://telia.dl.sourceforge.net/sourceforge/dosemu/dosemu-freedos-bin.tgz
	http://telia.dl.sourceforge.net/sourceforge/dosemu/dosemu-1.1.3.tgz"
HOMEPAGE="http://www.dosemu.org"
LICENSE="GPL | LGPL"
KEYWORDS="x86 -ppc"
SLOT="0"
DEPEND="X? ( virtual/x11 )
		svga? ( media-libs/svgalib )"
RDEPEND="${DEPEND}"	
src_compile() {

### We make base-configure executable here, so that we can pretend its our
### ./configure script, by passing it cli arguments, we bypass the usual
### DOSemu installation script routines :)

	chmod +x base-configure	

	local myflags

### mitshm will bork ./base-configure entirely, so we disable it here	
	myflags="--enable-mitshm=no"
	myflags="${myflags} --enable-experimental"

### and then set build paramaters based on USE variables
	use X || myflags="${myflags} --with-x=no"
	use svga && myflags="${myflags} --enable-use-svgalib"

### this is really a ./configure (honestly)
	./base-configure \
		${myflags} || die "DOSemu Base Configuration Failed"
	
### We HAVE to do this, or the build will fail due to strange additional
### files in the downloaded tarball!
	emake pristine || die "Dosemu Make Pristine Failed"

### Ok, the build tree is clean, lets make the executables, and 'dos' commands
	emake -C src || die "DOSemu Make Failed!"
	emake dosbin || die "DOSbin Make Failed"
}

src_install () {

### There is no 'make install' for DOSemu, just a set of install scripts
### We'll pass our portage image directory as the fs root, and 'install'
### as normal, this seems to stick with the usual gentoo standards

	./install_systemwide -fd ${DISTDIR}/dosemu-freedos-bin.tgz -r ${D}
	
### install_systemwide doesn't pay attention to our man/info locations
### we'll install them to the correct location with doman now that they've
### been created and remove them from the new source tree before emerge
### installs everything to our 'real' filesystem

	doman man/*.1 
	rm -rf ${D}/opt/dosemu/man/

}

