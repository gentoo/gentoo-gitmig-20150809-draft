# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ryan Tolboom <ryan@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-emulation/fceultra/fceu-054.ebuild,v 1.1 2001/05/26 00:39:56 ryan Exp $

A=fceu054src.tar.gz
S=${WORKDIR}/fceu
DESCRIPTION="A portable NES/Famicom Emulator"
SRC_URI="http://prdownloads.sourceforge.net/fceultra/${A}"
HOMEPAGE="http://fceultra.sourceforge.net"

DEPEND=">=media-libs/svgalib-1.4.2"

src_compile() {

    cp Makefile.base Makefile.orig
    cat Makefile.orig | sed "s:\${TFLAGS}:\${TFLAGS} ${CFLAGS}:" > Makefile.base 
    try make -f Makefile.linuxvga

}

src_install () {

    dobin fce
    dodoc Documentation/*

}
