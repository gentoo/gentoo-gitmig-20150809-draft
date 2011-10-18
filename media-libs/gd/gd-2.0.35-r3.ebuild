# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gd/gd-2.0.35-r3.ebuild,v 1.5 2011/10/18 14:19:20 jer Exp $

EAPI="2"

inherit autotools eutils

DESCRIPTION="A graphics library for fast image creation"
HOMEPAGE="http://libgd.org/ http://www.boutell.com/gd/"
SRC_URI="http://libgd.org/releases/${P}.tar.bz2"

LICENSE="|| ( as-is BSD )"
SLOT="2"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE="fontconfig jpeg png static-libs truetype xpm zlib"

RDEPEND="fontconfig? ( media-libs/fontconfig )
	jpeg? ( virtual/jpeg )
	png? ( >=media-libs/libpng-1.5:0 )
	truetype? ( >=media-libs/freetype-2.1.5 )
	xpm? ( x11-libs/libXpm x11-libs/libXt )
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-libpng14.patch #305101
	epatch "${FILESDIR}"/${P}-maxcolors.patch #292130
	epatch "${FILESDIR}"/${P}-fontconfig.patch #363367

	# Try libpng15 first, then fallback to plain libpng
	sed -i -e 's:png12:png15:' configure.ac || die

	# Avoid programs we never install
	sed -i '/^noinst_PROGRAMS/s:=:=\n___fooooo =:' Makefile.in || die

	if ! use png ; then
		sed -i -r \
			-e '/^bin_PROGRAMS/,/^noinst_PROGRAMS/s:(gdparttopng|gdtopng|gd2topng|pngtogd|pngtogd2|webpng)..EXEEXT.::g' \
			Makefile.in || die
	fi
	if ! use zlib ; then
		sed -i -r \
			-e '/^bin_PROGRAMS/,/^noinst_PROGRAMS/s:(gd2topng|gd2copypal|gd2togif|giftogd2|gdparttopng)..EXEEXT.::g' \
			Makefile.in || die
	fi

	eautoconf
	find . -type f -print0 | xargs -0 touch -r configure
}

usex() { use $1 && echo ${2:-yes} || echo ${3:-no} ; }
src_configure() {
	export ac_cv_lib_z_deflate=$(usex zlib)
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
	use static-libs || rm -f "${D}"/usr/*/libgd.la
}
