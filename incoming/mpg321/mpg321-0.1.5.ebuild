# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author David Rufino <daverufino@btinternet.com>

A=${PN}_${PV}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Free mp3 player"
SRC_URI="http://people.debian.org/~drew/${A}"
HOMEPAGE="http://people.debian.org/~drew/"
PATCH="mpg321-0.1.5-ao.diff"

DEPEND="virtual/glibc
	>=media-sound/mad-0.13.0b
	>=media-libs/libao-0.8.0"

src_unpack () {
    unpack ${A}
    try patch -p0 < ${FILESDIR}/${PATCH}
    cd ${S}
}

src_compile() {

    try ./configure --prefix=/usr
    try make

}

src_install () {
	try true
}


