# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# /home/cvsroot/gentoo-x86/media-sound/lame/lame-3.86b.ebuild,v 1.4 2000/11/02 02:17:12 achim Exp

A=lame3.88beta.tar.gz
S=${WORKDIR}/lame-3.88
CATEGORY="media-sound"
DESCRIPTION="LAME Ain't an Mp3 Encoder"
SRC_URI="ftp://lame.sourceforge.net/pub/lame/src/${A}"
HOMEPAGE="http://www.mp3dev.org/mp3/"

DEPEND="virtual/glibc dev-lang/nasm >=sys-libs/ncurses-5.2
	gtk? ( >=x11-libs/gtk+-1.2.8 )"
        #vorbis? ( >=media-libs/libvorbis-1.0_beta4 )"

RDEPEND="virtual/glibc >=sys-libs/ncurses-5.2
	gtk? ( >=x11-libs/gtk+-1.2.8 )"
        #vorbis? ( >=media-libs/libvorbis-1.0_beta4 )"

src_unpack () {

  unpack ${A}
  cd ${S}
#  cp Makefile Makefile.orig
#  sed -e "s:-O3:${CFLAGS}:" Makefile.orig > Makefile

}

src_compile() {

    local myconf
    if [ "`use vorbis`" ] ; then
      #myconf="--with-vorbis"
      myconf="--without-vorbis"
    else
      myconf="--without-vorbis"
    fi
    if [ "`use gtk`" ] ; then
      myconf="$myconf --enable-mp3x"
    fi
    if [ "$DEBUG" ] ; then
        myconf="$myconf --enable-debug=yes"
    else
        myconf="$myconf --enable-debug=no"
    fi
    try ./configure --enable-shared --prefix=/usr --enable-extopt=full $myconf
    try make

}

src_install () {

    if [ "`use gtk`" ] ; then
      dobin frontend/.libs/mp3x
    fi
    dobin frontend/.libs/lame
    dolib.a  libmp3lame/.libs/libmp3lame.a  libmp3lame/.libs/libmp3lame.la
    dolib.so  libmp3lame/.libs/libmp3lame.so*
    insinto /usr/include
    doins include/lame.h
    doman doc/man/lame.1
    dodoc API COPYING HACKING PRESETS.draft LICENSE README* TODO USAGE
    docinto html
    dodoc doc/html/*.html doc/html/*.css

}



