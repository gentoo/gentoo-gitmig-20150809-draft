# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/mpeg-movie/mpeg-movie-1.6.0.ebuild,v 1.4 2000/08/16 15:08:41 achim Exp $

P=mpeg-movie-1.6.0
A=mpeg_movie-1.6.0.tar.gz
S=${WORKDIR}/mpeg_movie
DESCRIPTION="Tools for MPEG-I movies"
SRC_URI="http://heroine.linuxave.net/${A}"
HOMEPAGE="http://heroine.linuxave.net/toys.html"

src_unpack() {
  unpack ${A}
  cd ${S}
  for i in video_in video_out
  do
    cd ${S}/${i}
    cp Makefile Makefile.orig
    sed -e "s:gnu/types\.h:bits/types\.h:" \
	-e "s:stdio_lim\.h:bits/stdio_lim\.h:" \
	-e "s:bytesex\.h::" \
	-e "s:selectbits\.h::" \
	-e "s:huge_val\.h:bits/huge_val\.h:" \
	-e "s:mathcalls\.h:bits/mathcalls\.h:" \
	-e "s:posix1_lim\.h:bits/posix1_lim\.h:" \
	-e "s:posix2_lim\.h:bits/posix2_lim\.h:" \
	-e "s:posix_opt\.h:bits/posix_opt\.h:" \
	-e "s:local_lim\.h:bits/local_lim\.h:" \
	-e "s:socketbits\.h::" \
	-e "s:sockaddrcom\.h::" \
	-e "s:errnos\.h::" \
	-e "s:statbuf\.h::" \
	-e "s:ipc_buf\.h::" \
	-e "s:shm_buf\.h::" \
	-e "s:timebits\.h::" \
	-e "s:confname\.h:bits/confname\.h:" \
	-e "s:sigset\.h:bits/sigset\.h:" \
	-e "s:signum\.h:bits/signum\.h:" \
	-e "s:sigaction\.h:bits/sigaction\.h:" \
	-e "s:asm/sigcontext\.h:bits/sigcontext\.h:" \
	-e "s:include/sigcontext\.h:include/bits/sigcontext\.h:" \
	Makefile.orig > Makefile

  done
  cd ${S}/audio_out
  cp GNUmake GNUmake.orig
  sed -e "s:SDL_DIR += /usr/local:SDL_DIR += /usr:" GNUmake.orig > GNUmake
}
src_compile() {

    cd ${S}
    make

}

src_install () {

    cd ${S}
    into /usr
    newbin audio_in/encode mpeg_audio_encode
    newbin audio_out/plaympeg mpeg_audio_play
    newbin mplex_in/mplex mpeg_mplex
    newbin mplex_out/dmplex mpeg_dmplex
    newbin video_in/mpeg_encode mpeg_video_encode
    dobin video_out/mpeg_play

    dodoc docs/*.txt
    docinto html
    dodoc docs/index.html
    docinto html/quicktime
    dodoc quicktime4linux/src/docs/*.html
}





