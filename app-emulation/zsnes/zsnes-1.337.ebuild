# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-emulation/zsnes/zsnes-1.337.ebuild,v 1.2 2001/10/06 08:48:17 danarmak Exp $
# Don't attempt to introduce $CFLAGS usage, docs say result will be slower.

DESCRIPTION="zsnes is an excellent snes (super nintendo) emulator"

SRC_URI="http://prdownloads.sourceforge.net/zsnes/zsnes1337src.tar.gz"

HOMEPAGE="http://www.zsnes.com/"

S=${WORKDIR}/${P}

DEP="opengl? ( virtual/opengl )
    virtual/x11
    >=media-libs/libsdl-1.2.0
    sys-libs/zlib
    media-libs/libpng"

DEPEND="sys-devel/gcc
	virtual/glibc
	sys-devel/make
	>=dev-lang/nasm-0.98
	$DEP"
	
RDEPEND="$DEP"

src_compile() {
    cd ${S}/src
    use opengl || myconf="--without-opengl"
    ./configure --prefix=/usr --host=${CHOST} $myconf || die
    make
}
src_install () {
    cd ${S}/src
    into /usr
    dobin zsnes
    doman linux/zsnes.man
    cd ${S}
    dodoc *.txt linux/*
}

