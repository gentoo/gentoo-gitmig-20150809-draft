# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/mpeg2-movie/mpeg2-movie-1.2.1.ebuild,v 1.1 2000/08/15 19:44:01 achim Exp $

P=mpeg2-movie-1.2.1
A=mpeg2_movie-1.2.1.tar.gz
S=${WORKDIR}/mpeg2_movie-1.2.1
CATEGORY="media-video"
DESCRIPTION="An MPEG2 encoder"
SRC_URI="http://heroine.linuxave.net/${A}"
HOMEPAGE="http://heroine.linuxave.net/mpeg2movie.html"


src_compile() {

    cd ${S}
    ./configure
    make

}

src_install () {

    cd ${S}
    into /usr
    newbin video/encode mpeg2_video_encode
    newbin audio/encode mpeg2_audio_encode
    newbin mplex/mplex mpeg2_mplex
    dobin libmpeg3/mpeg3cat
    dodoc video/CHANGES video/TODO
    docinto html
    dodoc docs/index.html
}


