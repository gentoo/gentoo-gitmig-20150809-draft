# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jens Blaesche <mr.big@pc-trouble.de>

S=${WORKDIR}/${P}
A=${P}.tar.gz
DESCRIPTION="Motion is a nice tool to use a v4l-device as a supervision-camera."
SRC_URI="http://motion.technolust.cx/download/${A}"
HOMEPAGE="http://motion.technolust.cx"

DEPEND=">=media-video/mpeg-tools-1.5"

src_compile() {
    ./configure --host=${CHOST}	--prefix=/usr	
    make || die
}

src_install () {
 
    exeinto /usr/bin
    doexe motion
    insinto /etc
    doins motion.conf
    dodoc CREDITS COPYING CHANGELOG INSTALL README TODO
    doman ${S}/motion.1 
}
