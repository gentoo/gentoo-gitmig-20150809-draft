# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Donny Davies <woodchip@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/musicbrainz/musicbrainz-1.0.0.ebuild,v 1.1 2001/09/22 05:34:59 woodchip Exp $

DESCRIPTION="Client library to access free metadata about mp3/vorbis/CD media"
S=${WORKDIR}/${P}
SRC_URI="ftp://ftp.musicbrainz.org/pub/musicbrainz/${P}.tar.gz"
HOMEPAGE="http://www.musicbrainz.org/"

DEPEND="virtual/glibc"

src_compile() {
	CC="gcc ${CFLAGS}" ./configure --prefix=/usr --mandir=/usr/share/man \
		--host=${CHOST} ; assert
	emake ; assert
}

src_install() {
	make prefix=${D}/usr install ; assert
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO docs/mb_howto.txt
}
