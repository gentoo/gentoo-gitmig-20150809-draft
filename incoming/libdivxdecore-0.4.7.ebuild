# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Michael Nazaroff <naz@themooonsofjupiter.net>
# /home/cvsroot/gentoo-x86/media-libs/libdivxdecore/libdivxdecore-0.4.7.ebuild,v 1.2 2001/08/27

A=libdivxdecore-0.4.7.tar.gz
S=${WORKDIR}/libdivxdecore-0.4.7
DESCRIPTION="Project Mayo's OpenDivX for Mpeg-4"
SRC_URI="http://download2.projectmayo.com/dnload/divx4linux/xmps/${A}"
HOMEPAGE="http://www.projectmayo.com"

DEPEND="virtual/glibc"

src_compile() {

    try ./configure --prefix=/usr --host=${CHOST}
    try make
}

src_install () {

    try make DESTDIR=${D} install

    dodoc AUTHORS COPYING README

}