# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/mad/mad-0.13.0b.ebuild,v 1.1 2001/08/24 19:00:07 danarmak Exp $

S=${WORKDIR}/${P}
SRC_URI="ftp://ftp.mars.org/pub/mpeg/${P}.tar.gz"

HOMEPAGE="http://www.mars.org/home/rob/proj/mpeg/"
DESCRIPTION="A high-quality mp3 decoder"

DEPEND="sys-devel/gcc virtual/glibc sys-devel/ld.so"
RDEPEND="virtual/glibc sys-devel/ld.so""

src_compile() {
    
    confopts="--infodir=/usr/share/info --mandir=/usr/share/man \
			  --prefix=/usr --host=${CHOST} --enable-static \
			  --disable-debugging --enable-shared --enable-fpm=intel"
    
    try ./configure ${confopts}
    
    try emake

}

src_install () {

    try make DESTDIR=${D} install

}

