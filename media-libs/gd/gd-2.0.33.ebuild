# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gd/gd-2.0.33.ebuild,v 1.12 2006/04/23 20:48:09 flameeyes Exp $

inherit eutils libtool autotools

DESCRIPTION="A graphics library for fast image creation"
HOMEPAGE="http://www.boutell.com/gd/"
SRC_URI="http://www.boutell.com/gd/http/${P}.tar.gz"

LICENSE="|| ( as-is BSD )"
SLOT="2"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ~ppc-macos ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="fontconfig jpeg png truetype xpm"

DEPEND="fontconfig? ( media-libs/fontconfig )
	jpeg? ( >=media-libs/jpeg-6b )
	png? ( >=media-libs/libpng-1.2.5 sys-libs/zlib )
	truetype? ( >=media-libs/freetype-2.1.5 )
	xpm? ( || ( ( x11-libs/libXpm x11-libs/libXt ) virtual/x11 ) )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-overflow-checks.patch
	epatch "${FILESDIR}/${P}-iconv.patch"

	eautomake

	elibtoolize #117078
}

src_compile() {
	econf \
		$(use_with fontconfig) \
		$(use_with png) \
		$(use_with truetype freetype) \
		$(use_with jpeg) \
		$(use_with xpm) \
		|| die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc INSTALL README*
	dohtml -r ./
}
