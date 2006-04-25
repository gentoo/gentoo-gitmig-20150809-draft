# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libextractor/libextractor-0.5.12.ebuild,v 1.1 2006/04/25 05:10:17 squinky86 Exp $

inherit libtool eutils

IUSE="gtk nls static vorbis zlib"
DESCRIPTION="A simple library for keyword extraction"
HOMEPAGE="http://www.gnunet.org/libextractor"
SRC_URI="http://gnunet.org/${PN}/download/${P}.tar.gz"
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
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
	econf --enable-glib --enable-exiv2 \
		`use_enable static` `use_enable nls` || die "econf failed"
	make || die "compile failed"
}

src_install () {
	make DESTDIR=${D} install || die "install failed"
}
