# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gavl/gavl-1.0.0.ebuild,v 1.1 2008/05/18 12:41:57 drac Exp $

inherit autotools eutils

DESCRIPTION="library for handling uncompressed audio and video data"
HOMEPAGE="http://gmerlin.sourceforge.net"
SRC_URI="mirror://sourceforge/gmerlin/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=""
DEPEND="doc? ( app-doc/doxygen )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# someone should cluebat upstream
	epatch "${FILESDIR}"/${PN}-0.2.7-cflags-and-includedir.patch
	sed -i -e "s:-mfpmath=387::g" configure.ac || die "sed failed."
	AT_M4DIR="m4" eautoreconf
}

src_compile() {
	# --disable-libpng because it's only used for tests
	econf $(use_with doc doxygen) --disable-libpng \
		--without-cpuflags --disable-dependency-tracking \
		--docdir=/usr/share/doc/${PF}/html
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS README TODO
}
