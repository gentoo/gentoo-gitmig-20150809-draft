# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/lame/lame-3.86b.ebuild,v 1.2 2000/09/15 20:09:04 drobbins Exp $

P=lame-3.86b
A=lame3.86beta.tar.gz
S=${WORKDIR}/lame3.86
CATEGORY="media-sound"
DESCRIPTION="LAME Ain't an Mp3 Encoder"
SRC_URI="http://www.sulaco.org/mp3/download/beta/${A}"
HOMEPAGE="http://www.sulaco.org/mp3/"

src_unpack () {

  unpack ${A}
  cd ${S}
  cp Makefile Makefile.orig
  sed -e "s:-O3:${CFLAGS}:" Makefile.orig > Makefile

}

src_compile() {

    cd ${S}
    try make

}

src_install () {

    cd ${S}
    into /usr
    dobin lame
    doman doc/man/lame.1
    dodoc API COPYING HACKING PRESETS.draft LICENSE README* TODO USAGE
    docinto html
    dodoc doc/html/*.html doc/html/*.css

}



