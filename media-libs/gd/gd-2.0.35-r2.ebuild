# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gd/gd-2.0.35-r2.ebuild,v 1.3 2011/04/11 14:21:39 ssuominen Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="A graphics library for fast image creation"
HOMEPAGE="http://libgd.org/"
SRC_URI="http://libgd.org/releases/${P}.tar.bz2"

LICENSE="|| ( as-is BSD )"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE="fontconfig jpeg png static-libs truetype xpm"

RDEPEND="fontconfig? ( media-libs/fontconfig )
	jpeg? ( virtual/jpeg )
	png? ( >=media-libs/libpng-1.4
		sys-libs/zlib )
	truetype? ( >=media-libs/freetype-2.1.5 )
	xpm? ( x11-libs/libXpm x11-libs/libXt )"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-libpng14.patch \
		"${FILESDIR}"/${P}-maxcolors.patch

	# Try libpng14 first, then fallback to plain libpng
	sed -i -e 's:png12:png14:' configure.ac || die

	eautoconf
	find . -type f -print0 | xargs -0 touch -r configure
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_with fontconfig) \
		$(use_with png) \
		$(use_with truetype freetype) \
		$(use_with jpeg) \
		$(use_with xpm)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc INSTALL README*
	dohtml -r ./
	use static-libs || rm -f "${D}"/usr/lib*/libgd.la
}
