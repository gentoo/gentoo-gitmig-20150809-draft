# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/mpeg2-movie/mpeg2-movie-1.5.ebuild,v 1.2 2001/05/09 10:21:22 achim Exp $

P=mpeg2-movie-${PV}
A=mpeg2_movie-${PV}.tar.gz
S=${WORKDIR}/mpeg2_movie-${PV}
DESCRIPTION="An MPEG2 encoder"
SRC_URI="http://heroinewarrior.com/${A}"
HOMEPAGE="http://heroinewarrior.com/mpeg2movie.php3"

DEPEND=">=sys-libs/glibc-2.1.3
	>=dev-libs/glib-1.2.8
	>=media-libs/libpng-1.0.7
	>=dev-lang/nasm-0.98"

src_unpack() {
    unpack ${A}
}
src_compile() {

    export CFLAGS="${CFLAGS} `gtk-config --cflags`"
    try ./configure
    try make -e CFLAGS=\"${CFLAGS}\"

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




