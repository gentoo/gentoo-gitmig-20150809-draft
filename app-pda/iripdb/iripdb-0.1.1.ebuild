# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/iripdb/iripdb-0.1.1.ebuild,v 1.1 2004/09/22 18:08:50 fafhrd Exp $

S=${WORKDIR}/iRipDB-${PV}

inherit eutils

DESCRIPTION="iRipDB allows generating the DB files necessary for the iRiver iHP-1xx series of MP3/Ogg HD Player on Linux and Windows."
HOMEPAGE="http://www.marevalo.net/iRipDB"
SRC_URI="http://www.marevalo.net/iRipDB/iRipDB-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND="virtual/libc
	=media-libs/id3lib-3.8.3*
	=media-libs/libogg-1.1*
	=media-libs/libvorbis-1.0.1*
	=sys-libs/zlib-1.2.1*"

src_compile() {
	gcc -c -o main.o main.c
	gcc -c -o vcedit.o vcedit.c
	gcc -o iripdb main.o vcedit.o -L/usr/lib -lz -lm -lid3 -lvorbis -logg -lstdc++
}

src_install() {
	dobin iripdb
	dodoc AUTHORS README doc/iRivDB_structure
}

