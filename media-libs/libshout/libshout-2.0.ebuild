# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libshout/libshout-2.0.ebuild,v 1.3 2004/04/08 07:58:18 eradicator Exp $

DESCRIPTION="libshout is a library for connecting and sending data to icecast servers."
SRC_URI="http://www.icecast.org/files/libshout/${P}.tar.gz"
HOMEPAGE="http://www.icecast.org"

SLOT="0"
KEYWORDS="x86 ~sparc ~amd64"
LICENSE="GPL-2"

RDEPEND="virtual/glibc
	 media-libs/libogg
	 media-libs/libvorbis"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc README INSTALL examples/example.c

	rm -rf ${D}/usr/share/doc/libshout
}
