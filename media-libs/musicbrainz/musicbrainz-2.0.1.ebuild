# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/musicbrainz/musicbrainz-2.0.1.ebuild,v 1.1 2003/03/23 09:22:39 jje Exp $

DESCRIPTION="Client library to access free metadata about mp3/vorbis/CD media"
S=${WORKDIR}/lib${P}
SRC_URI="ftp://ftp.musicbrainz.org/pub/musicbrainz/lib${P}.tar.gz"
HOMEPAGE="http://www.musicbrainz.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc  ~ppc ~alpha"

DEPEND="virtual/glibc"

src_compile() {
	CC="gcc ${CFLAGS}" \
	econf || die
	emake || die "compile problem"
}

src_install() {
        dodir /usr/lib/pkgconfig
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO docs/mb_howto.txt
}
