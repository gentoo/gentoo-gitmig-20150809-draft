# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libshout/libshout-2.0.ebuild,v 1.10 2004/08/27 02:57:43 tgall Exp $

IUSE=""

DESCRIPTION="libshout is a library for connecting and sending data to icecast servers."
SRC_URI="http://www.icecast.org/files/libshout/${P}.tar.gz"
HOMEPAGE="http://www.icecast.org"

SLOT="0"
KEYWORDS="x86 sparc amd64 ~ppc ppc64"
LICENSE="GPL-2"

RDEPEND="virtual/libc
	 media-libs/libogg
	 media-libs/libvorbis"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc README INSTALL examples/example.c

	rm -rf ${D}/usr/share/doc/libshout
}
