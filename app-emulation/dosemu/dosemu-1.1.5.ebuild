# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/dosemu/dosemu-1.1.5.ebuild,v 1.2 2003/06/18 14:23:36 hanno Exp $

IUSE="X svga"

P_FD=dosemu-freedos-b8p-bin
S=${WORKDIR}/${P}
DESCRIPTION="DOS Emulator"
SRC_URI="mirror://sourceforge/dosemu/${P_FD}.tgz
	mirror://sourceforge/dosemu/${P}.tgz"
HOMEPAGE="http://www.dosemu.org/"
LICENSE="GPL-2 | LGPL-2.1"
KEYWORDS="x86 -ppc"
SLOT="0"
DEPEND="X? ( virtual/x11 )
	svga? ( media-libs/svgalib )
	sys-libs/slang"

src_unpack() {
	unpack ${P}.tgz
	# extract freedos binary
	cd ${S}/src
	unpack ${P_FD}.tgz
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
	cp ${DISTDIR}/${P_FD}.tgz ${D}/usr/share/dosemu/dosemu-freedos-bin.tgz
}

