# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/mpeg2-movie/mpeg2-movie-1.2.2.ebuild,v 1.4 2000/11/15 22:57:41 achim Exp $

P=mpeg2-movie-1.2.2
A=mpeg2_movie-1.2.2.tar.gz
S=${WORKDIR}/mpeg2_movie-1.2.2
DESCRIPTION="An MPEG2 encoder"
SRC_URI="http://heroine.linuxave.net/${A}"
HOMEPAGE="http://heroine.linuxave.net/mpeg2movie.html"

DEPEND=">=sys-libs/glibc-2.1.3
	>=dev-libs/glib-1.2.8
	>=media-libs/libpng-1.0.7
	>=dev-lang/nasm-0.98"

src_unpack() {
    unpack ${A}
    cd ${S}/mplex
    cp Makefile Makefile.orig
    sed -e "s:-lpthread:-lpthread -lm:" Makefile.orig > Makefile
}
src_compile() {

    cd ${S}
    try ./configure
    try make

}

src_install () {

    cd ${S}
    into /usr
    newbin video/encode mpeg2_video_encode
    newbin audio/encode mpeg2_audio_encode
    newbin mplex/mplex mpeg2_mplex
    dobin libmpeg3/mpeg3cat
    dodoc script video/CHANGES video/TODO
    docinto html
    dodoc docs/index.html
}




