# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/musicbrainz/musicbrainz-2.0.2.ebuild,v 1.1 2003/08/17 09:55:58 g2boojum Exp $

IUSE=""

inherit libtool

S="${WORKDIR}/lib${P}"

DESCRIPTION="Client library to access metadata of mp3/vorbis/CD media"
SRC_URI="ftp://ftp.musicbrainz.org/pub/musicbrainz/lib${P}.tar.gz"
HOMEPAGE="http://www.musicbrainz.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc ~alpha"

DEPEND="virtual/glibc
	dev-libs/expat"
RDEPEND="dev-util/pkgconfig"

src_compile() {
	local myconf="--enable-cpp-headers --with-gnu-ld"
	econf ${myconf} || die "configure failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc AUTHORS ChangeLog INSTALL README TODO docs/mb_howto.txt
}
