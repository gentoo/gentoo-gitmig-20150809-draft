# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Peter Gavin <pete@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/glide/glide-3.0.20000312.ebuild,v 1.2 2001/08/11 03:50:11 drobbins Exp $

#P=
A=${P}.tar.bz2
S=${WORKDIR}/glide3x
DESCRIPTION="the 3Dfx Glide library for Voodoo3 graphics cards"
SRC_URI="ftp://ftp.ibiblio.org/pub/Linux/distributions/gentoo/gentoo-sources/${A}"
HOMEPAGE="http://glide.sourceforge.net/"

DEPEND=">=x11-base/xfree-4.0"

src_compile() {
    cd ${S}
    try aclocal
    try autoconf
    try automake
    mkdir build
    cd build
    try ../configure --prefix=/usr --host=${CHOST} \
	--enable-fx-glide-hw=h3 --enable-fx-build-dri
    try make -f makefile.autoconf GLIDE_DEBUG_GCFLAGS="${CFLAGS}"
}

src_install () {
    cd ${S}/build
	#OK, shouldn't need to specify GCFLAGS below, removed (DR)
    #try make -f makefile.autoconf GLIDE_DEBUG_GCFLAGS="${CFLAGS}" DESTDIR=${D} install
    try make -f makefile.autoconf DESTDIR=${D} install
    
    cd ${S}
    dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}

