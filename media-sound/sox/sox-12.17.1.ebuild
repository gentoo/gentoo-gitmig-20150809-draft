# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/sox/sox-12.17.1.ebuild,v 1.12 2002/07/12 21:24:25 phoenix Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="The swiss army knife of sound processing programs"
SRC_URI="http://download.sourceforge.net/sox/${A}"
HOMEPAGE="http://home.sprynet.com/~cgabwell/sox.html"
KEYWORDS="x86"
SLOT="0"
LICENSE="LPGL-2.1"

DEPEND="virtual/glibc alsa? ( virtual/alsa )"

src_compile() {
    local myconf
    if [ "`use alsa`" ] ; then
	myconf="--with-alsa-dsp"
    fi
    try ./configure --prefix=/usr --host=${CHOST} \
	 --enable-fast-ulaw --enable-fast-alaw $myconf
    try make

}

src_install () {
    into /usr
    dobin sox play soxeffect
    doman sox.1 soxexam.1
    dodoc Changelog Copyright README TODO *.txt

}


