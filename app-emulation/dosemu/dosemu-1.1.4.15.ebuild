# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/dosemu/dosemu-1.1.4.15.ebuild,v 1.1 2003/04/16 12:12:57 liquidx Exp $

IUSE="X svga"

MAJOR_PV=${PV%.[0-9]*}
MINOR_PV=${PV##[0-9]*.}
S=${WORKDIR}/${PN}-${MAJOR_PV}
DESCRIPTION="DOS Emulator"
SRC_URI="mirror://sourceforge/dosemu/${PN}-freedos-bin.tgz
	mirror://sourceforge/dosemu/${PN}-${MAJOR_PV}.tgz
	http://dosemu.sourceforge.net/testing/patchset-${PV}.tgz"
HOMEPAGE="http://www.dosemu.org/"
LICENSE="GPL-2 | LGPL-2.1"
KEYWORDS="~x86 -ppc"
SLOT="0"
DEPEND="X? ( virtual/x11 )
	svga? ( media-libs/svgalib )
	sys-libs/slang"

src_unpack() {
	unpack ${PN}-${MAJOR_PV}.tgz
	# do patches
	cd ${S}
	unpack patchset-${PV}.tgz
	sh tmp/do_patch || die
	# extract freedos binary
	cd ${S}/src
	unpack ${PN}-freedos-bin.tgz
}

src_compile() {

	local myflags

### mitshm will bork ./base-configure entirely, so we disable it here
	myflags="--enable-mitshm=no"
	myflags="${myflags} --enable-experimental"
	myflags="${myflags} --disable-force-slang"

### and then set build paramaters based on USE variables
	use X || myflags="${myflags} --with-x=no"
	use svga && myflags="${myflags} --enable-use-svgalib"

	econf ${myflags} || die "DOSemu Base Configuration Failed"

### We HAVE to do this, or the build will fail due to strange additional
### files in the downloaded tarball!
#	emake pristine || die "Dosemu Make Pristine Failed"

### Ok, the build tree is clean, lets make the executables, and 'dos' commands
	emake -C src || die "DOSemu Make Failed!"
	emake dosbin || die "DOSbin Make Failed"
}

src_install () {

	make DESTDIR=${D} install || die

	doman man/*.1
	rm -rf ${D}/opt/dosemu/man/
	
	mv ${D}/usr/share/doc/dosemu ${D}/usr/share/doc/${PF}
	
	# freedos tarball is needed in /usr/share/dosemu
	cp ${DISTDIR}/${PN}-freedos-bin.tgz ${D}/usr/share/dosemu
	
}

