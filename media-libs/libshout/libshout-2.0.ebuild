# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libshout/libshout-2.0.ebuild,v 1.1 2003/08/15 03:41:28 g2boojum Exp $

DESCRIPTION="libshout is a library for connecting and sending data to icecast servers."
SRC_URI="http://www.icecast.org/files/libshout/${P}.tar.gz"
HOMEPAGE="http://www.icecast.org"

SLOT="0"
KEYWORDS="~x86 ~sparc"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	media-libs/libogg
	media-libs/libvorbis"
RDEPEND="dev-util/pkgconfig"

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc README INSTALL examples/example.c

	rm -rf ${D}/usr/share/doc/libshout
}
