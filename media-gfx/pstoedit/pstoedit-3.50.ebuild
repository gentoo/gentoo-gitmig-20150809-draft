# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pstoedit/pstoedit-3.50.ebuild,v 1.3 2009/11/24 04:35:57 jer Exp $

EAPI="2"

inherit autotools eutils

DESCRIPTION="Translate PostScript and PDF graphics into other vector formats"
HOMEPAGE="http://www.pstoedit.net/pstoedit"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha amd64 hppa ~ia64 ~ppc ~ppc64 ~sparc x86"

IUSE="emf imagemagick plotutils"

RDEPEND="media-libs/libpng
		media-libs/gd
		virtual/ghostscript
		emf?			( >=media-libs/libemf-1.0.3 )
		imagemagick?	( media-gfx/imagemagick[-nocxx] )
		plotutils?		( media-libs/plotutils )"
#		swf?			( >=media-libs/ming-0.3 )" bug 238803

DEPEND="${RDEPEND}
		dev-util/pkgconfig"

src_prepare() {
	sed -i -e 's:-pedantic ::' -e 's:CXXFLAGS="-g"::' "${S}"/configure.ac
	epatch "${FILESDIR}"/${P}-parallel.patch
	epatch "${FILESDIR}"/${P}-plugin-close.patch
	eautoreconf
}

src_configure() {
	econf \
		$(use_with emf) \
		$(use_with imagemagick magick) \
		$(use_with plotutils libplot) \
		--without-swf \
		|| die 'econf failed'
#		$(use_with swf) \ # bug 238803
}

src_install () {
	emake DESTDIR="${D}" install || die 'make install failed'
	cd doc
	dodoc readme.txt || die
	dohtml *.htm || die
	doman pstoedit.1 || die
}
