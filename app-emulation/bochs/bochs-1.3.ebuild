# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Chris Arndt <arndtc@mailandnews.com>
# Maintainer: Dan Armak <danarmak@gentoo.org>

PN=${P/_/.}
S=${WORKDIR}/${PN}
DESCRIPTION="Bochs is a pc emulator.
  This ebuild is set up to emulate a Pentium, with a NE2000 network card, and a
CDROM drive.
  It also comes with a disk image using dlxlinux."
SRC_URI="http://prdownloads.sourceforge.net/bochs/${PN}.tar.gz
	 http://bochs.sourceforge.net/guestos/dlxlinux2.tar.gz"
HOMEPAGE="http://bochs.sourceforge.net"

#build-time dependencies
DEPEND=">=sys-libs/glibc-2.1.3
        >=x11-base/xfree-4.0.1"

src_unpack() {
    
    unpack ${PN}.tar.gz
    
    cd $S
    cp Makefile.in 1
    sed -e "s:\$(WGET) \$(DLXLINUX_TAR_URL):cp ${DISTDIR}/dlxlinux2.tar.gz .:" \
	-e 's: $(prefix): $(DESTDIR)$(prefix):g' \
	-e 's: $(bindir): $(DESTDIR)$(bindir):g' \
	-e 's: $(BOCHSDIR): $(DESTDIR)$(BOCHSDIR):g' 1 > Makefile.in
        
}

src_compile() {

        ./configure --enable-fpu --enable-cdrom --enable-control-panel \
	--enable-ne2000 --enable-sb16=linux -enable-slowdown --prefix=/usr \
	--infodir=/usr/share/info --mandir=/usr/share/man --host=${CHOST} || die

#        cp Makefile Makefile.orig
#        sed -e 's:$(BOCHSDIR)/dlxlinux:$(DESTDIR)$(BOCHSDIR)/dlxlinux:; \
#s:$(GUNZIP) -c
#$(DLXLINUX_TAR) | (cd $(BOCHSDIR); tar -xvf -):$(GUNZIP) -c $(DLXLINUX_TAR) |
#(cd $(DESTDIR)$(BOCHSDIR); tar -xvf -):' Makefile.orig > Makefile

        emake || die
}


src_install () {

        make DESTDIR=${D} install || die
        dodoc CHANGES COPYING CVS README TESTFORM.txt
}

