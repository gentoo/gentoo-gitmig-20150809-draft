# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/transcode/transcode-0.5.3.ebuild,v 1.3 2002/04/15 21:47:41 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="video stream processing tool"
SRC_URI="http://www.theorie.physik.uni-goettingen.de/~ostreich/transcode/${P}.tgz"
HOMEPAGE="http://divx.euro.ru/"

# note: transcode can use pretty much any media-related package ever written as a plugin.
# an exhaustive dep list would make me add about 20-30 packages to portage. perhaps another time :-)

DEPEND=">=media-sound/lame-3.89
	media-libs/libdv
	media-libs/libmpeg3
	>=media-video/avifile-0.6"

src_compile() {

    cd ${S}
    ./configure --prefix=/usr  || die
    emake all || die

}

src_install () {

    make DESTDIR=${D} install || die

}

