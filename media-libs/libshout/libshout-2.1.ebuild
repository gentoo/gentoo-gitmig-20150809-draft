# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libshout/libshout-2.1.ebuild,v 1.5 2006/03/30 04:03:43 agriffis Exp $

IUSE=""

DESCRIPTION="libshout is a library for connecting and sending data to icecast servers."
SRC_URI="http://downloads.xiph.org/releases/libshout/${P}.tar.gz"
HOMEPAGE="http://www.icecast.org"

SLOT="0"
KEYWORDS="amd64 ~ia64 ppc ppc64 sparc x86"
LICENSE="GPL-2"

RDEPEND="media-libs/libogg
	media-libs/libvorbis"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc README examples/example.c

	rm -rf ${D}/usr/share/doc/libshout
}
