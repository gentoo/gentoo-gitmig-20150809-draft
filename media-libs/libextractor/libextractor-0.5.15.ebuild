# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libextractor/libextractor-0.5.15.ebuild,v 1.1 2007/01/12 22:39:43 armin76 Exp $

inherit libtool

IUSE="gtk nls static vorbis zlib"
DESCRIPTION="A simple library for keyword extraction"
HOMEPAGE="http://www.gnunet.org/libextractor"
SRC_URI="http://gnunet.org/${PN}/download/${P}.tar.gz"
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="amd64 ~ppc sparc x86"
# Disabled tests because they dont work (tester@g.o)
RESTRICT="test"
DEPEND="virtual/libc
	>=sys-devel/libtool-1.4.1
	>=dev-libs/glib-1.2.10
	media-libs/libmpeg2
	nls? ( sys-devel/gettext )
	gtk? ( >=x11-libs/gtk+-2.6.10 )
	zlib? ( sys-libs/zlib )
	vorbis? ( >=media-libs/libvorbis-1.0_beta4 )"

src_compile() {
	elibtoolize
	econf --enable-glib --enable-exiv2 \
		$(use_enable static) $(use_enable nls) || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
}
