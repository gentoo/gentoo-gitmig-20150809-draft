# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/musicbrainz/musicbrainz-1.0.1-r1.ebuild,v 1.1 2002/05/04 02:54:55 woodchip Exp $

DESCRIPTION="Client library to access free metadata about mp3/vorbis/CD media"
S=${WORKDIR}/${P}
SRC_URI="ftp://ftp.musicbrainz.org/pub/musicbrainz/${P}.tar.gz"
HOMEPAGE="http://www.musicbrainz.org/"

DEPEND="virtual/glibc"
LICENSE="GPL-2"
SLOT="0"

src_compile() {
	CC="gcc ${CFLAGS}" \
	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--host=${CHOST} || die "bad ./configure"

	emake || die "compile problem"
}

src_install() {
	make prefix=${D}/usr install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO docs/mb_howto.txt
}
