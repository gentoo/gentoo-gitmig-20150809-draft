# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/bochs/bochs-1.4.ebuild,v 1.13 2004/02/20 06:01:34 mr_bones_ Exp $

PN=${P/_/.}
S=${WORKDIR}/${PN}
DESCRIPTION="Bochs is a pc emulator.
This ebuild is set up to emulate a Pentium, with a NE2000 network card, and a
CDROM drive.
It also comes with a disk image using dlxlinux."
SRC_URI="mirror://sourceforge/bochs/${PN}.tar.gz
	 http://bochs.sourceforge.net/guestos/dlxlinux3.tar.gz"
HOMEPAGE="http://bochs.sourceforge.net"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

#build-time dependencies
DEPEND=">=sys-libs/glibc-2.1.3
	>=x11-base/xfree-4.0.1"

KEYWORDS="x86 ppc"

src_unpack() {
	unpack ${PN}.tar.gz

	cd $S
	cp Makefile.in Makefile.in.orig
	sed -e "s:\$(WGET) \$(DLXLINUX_TAR_URL):cp ${DISTDIR}/dlxlinux3.tar.gz .:" \
	-e 's: $(prefix): $(DESTDIR)$(prefix):g' \
	-e 's: $(bindir): $(DESTDIR)$(bindir):g' \
	-e 's: $(BOCHSDIR): $(DESTDIR)$(BOCHSDIR):g' Makefile.in.orig > Makefile.in

}

src_compile() {

	./configure --enable-fpu --enable-cdrom --enable-control-panel \
	--enable-ne2000 --enable-sb16=linux -enable-slowdown --prefix=/usr \
	--infodir=/usr/share/info --mandir=/usr/share/man --host=${CHOST} --with-x11 || die

	# there's an sdl interface now, but since we an only compile 1 interface at a time
	# i'd rather have xwindows.

	emake || die
}


src_install () {

	make DESTDIR=${D} install || die
	dodoc CHANGES COPYING CVS README TESTFORM.txt
}

