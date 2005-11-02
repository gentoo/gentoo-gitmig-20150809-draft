# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libextractor/libextractor-0.5.6a.ebuild,v 1.2 2005/11/02 17:08:09 gustavoz Exp $

inherit libtool eutils

IUSE="gtk nls static vorbis zlib"
DESCRIPTION="A simple library for keyword extraction"
HOMEPAGE="http://www.gnunet.org/libextractor"
SRC_URI="http://gnunet.org/${PN}/download/${P}.tar.gz"
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 sparc ~amd64 ~ppc"
# Disabled tests because they dont work (tester@g.o)
RESTRICT="test"
DEPEND="virtual/libc
	>=sys-devel/libtool-1.4.1
	>=dev-libs/glib-1.2.10
	nls? ( sys-devel/gettext )
	gtk? ( >=x11-libs/gtk+-2.6.10 )
	zlib? ( sys-libs/zlib )
	vorbis? ( >=media-libs/libvorbis-1.0_beta4 )"

src_compile() {
	elibtoolize
	econf --with-gnu-ld --enable-glib --enable-exiv2 \
		`use_enable static` `use_enable nls` || die "econf failed"
	make || die "compile failed"
}

src_install () {
	make DESTDIR=${D} install || die "install failed"
}
