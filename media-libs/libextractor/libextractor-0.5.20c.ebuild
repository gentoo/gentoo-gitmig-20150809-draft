# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libextractor/libextractor-0.5.20c.ebuild,v 1.3 2011/10/09 17:45:36 ssuominen Exp $

EAPI=4
inherit libtool

DESCRIPTION="A simple library for keyword extraction"
HOMEPAGE="http://www.gnunet.org/libextractor/"
SRC_URI="http://gnunet.org/${PN}/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~sparc ~x86"
IUSE="gtk nls vorbis zlib"

# Disabled tests because they dont work (tester@g.o)
RESTRICT="test"

RDEPEND=">=sys-devel/libtool-2.2.6b
	>=dev-libs/glib-2.0.0
	media-libs/libmpeg2
	nls? ( virtual/libintl )
	gtk? ( >=x11-libs/gtk+-2.6.10 )
	zlib? ( sys-libs/zlib )
	vorbis? ( >=media-libs/libvorbis-1.0_beta4 )"
DEPEND="${RDEPEND}"

src_prepare() {
	#bug 383585
	has_version '>=sys-libs/zlib-1.2.5.1-r1' && \
		sed -i -e '1i#define OF(x) x' src/plugins/oo/ooextractor.c

	elibtoolize
}

src_configure() {
	#bug #188169 -> --disable-xpdf
	econf \
		--enable-glib \
		--enable-exiv2 \
		--disable-xpdf \
		$(use_enable nls)
}

src_compile() {
	emake -j1
}
