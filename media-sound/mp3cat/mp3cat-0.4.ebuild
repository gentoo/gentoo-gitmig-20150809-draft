# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3cat/mp3cat-0.4.ebuild,v 1.1 2005/01/27 21:15:57 pkdawson Exp $

DESCRIPTION="mp3cat reads and writes MP3 files"
HOMEPAGE="http://tomclegg.net/mp3cat"
SRC_URI="http://tomclegg.net/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's:cc -o:${CC} ${CFLAGS} -o:' Makefile
}

src_install() {
	dobin mp3cat mp3log mp3log-conf mp3dirclean mp3http mp3stream-conf
}
