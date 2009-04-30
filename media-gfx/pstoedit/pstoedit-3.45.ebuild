# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pstoedit/pstoedit-3.45.ebuild,v 1.13 2009/04/30 18:22:59 aballier Exp $

inherit base eutils

DESCRIPTION="translates PostScript and PDF graphics into other vector formats"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.pstoedit.net/pstoedit"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"

# Add flash when media-libs/ming-0.3 gets out of package.mask
IUSE="emf imagemagick plotutils"

# Strangely when emerging with --as-needed libpng is not needed
DEPEND="media-libs/libpng
		virtual/ghostscript
		media-libs/gd
		emf? ( >=media-libs/libemf-1.0.3 )
		imagemagick? ( media-gfx/imagemagick )
		plotutils? ( media-libs/plotutils )"
#flash? ( >=media-libs/ming-0.3 )

pkg_setup() {
	if use imagemagick && built_with_use media-gfx/imagemagick nocxx; then
		eerror 'pstoedit with USE "imagemagick" requires media-gfx/imagemagick'
		eerror 'built with C++ bindings. Please recompile imagemagick with'
		eerror 'USE "-nocxx"'
		echo
		die 'missing imagemagick C++ header file Magick++.h'
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Fails due to imagemagick having 'long long' in its headers (at least in
	# 6.3.9.8).
	sed -i -e "s/-pedantic //" configure
	epatch "${FILESDIR}/${P}-gcc-4.3.patch"
	epatch "${FILESDIR}/${P}-gcc-4.4.patch"
}

src_compile() {
	#$(use_with flash swf)
	# --without-swf for bug https://bugs.gentoo.org/show_bug.cgi?id=137204
	econf $(use_with emf) --without-swf $(use_with imagemagick magick) \
		  $(use_with plotutils libplot) || die 'econf failed'
	make || die 'compilation failed'
}

src_install () {
	emake DESTDIR="${D}" install || die 'make install failed'
	cd doc
	dodoc readme.txt || die
	dohtml *.htm || die
	doman pstoedit.1 || die
}
