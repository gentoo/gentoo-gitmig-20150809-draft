# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-video/mpeg-movie/mpeg-movie-1.6.0-r1.ebuild,v 1.4 2002/07/19 10:47:49 seemant Exp $

MY_P=${PN/-/_}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Tools for MPEG-I movies"
SRC_URI="http://heroine.linuxave.net/${MY_P}-${PV}.tar.gz"
HOMEPAGE="http://heroine.linuxave.net/toys.html"

SLOT="0"
LICENSE="BSD LGPL-2 GPL-2"
KEYWORDS="x86"

DEPEND="virtual/x11
	>=media-libs/jpeg-6b
	>=media-libs/libsdl-1.1.5"

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
			-e "s:/usr/lib/X11:/usr/X11R6/lib:" \
			Makefile.orig > Makefile
	done

	cd ${S}/audio_out
	cp GNUmake GNUmake.orig
	sed -e "s:SDL_DIR += /usr/local:SDL_DIR += /usr:" GNUmake.orig > GNUmake
	if [ "`use nas`" ] ; then
		cp GNUmake GNUmake.orig
		sed -e "s#^SDLLIB := -L#SDLLIB := -L/usr/X11R6/lib -lXt -L#"	\
			GNUmake.orig > GNUmake
	fi

	cd ${S}/quicktime4linux/src
	cp Makefile Makefile.orig
	sed -e "s:c_flags:./c_flags:g"	\
		Makefile.orig > Makefile
  
  
}
src_compile() {

    emake || die

}

src_install () {

    into /usr
    newbin audio_in/encode mpeg_audio_encode
    newbin audio_out/plaympeg mpeg_audio_play
    newbin mplex_in/mplex mpeg_mplex
    newbin mplex_out/dmplex mpeg_dmplex
    newbin video_in/mpeg_encode mpeg_video_encode
    dobin video_out/mpeg_play

    dodoc docs/*.txt
	dohtml -r ./
}
