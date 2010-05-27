# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pstoedit/pstoedit-3.45-r1.ebuild,v 1.4 2010/05/27 10:54:29 maekke Exp $

EAPI="2"

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
		app-text/ghostscript-gpl
		media-libs/gd
		emf? ( >=media-libs/libemf-1.0.3 )
		imagemagick? ( media-gfx/imagemagick[cxx] )
		plotutils? ( media-libs/plotutils )"
#flash? ( >=media-libs/ming-0.3 )

src_prepare() {
	# Fails due to imagemagick having 'long long' in its headers (at least in
	# 6.3.9.8).
	sed -i -e "s/-pedantic //" configure
	epatch "${FILESDIR}"/${P}-am_path_pstoedit.patch # bug 175679 (fixed in	3.50)
	epatch "${FILESDIR}/${P}-gcc-4.3.patch"
	epatch "${FILESDIR}/${P}-gcc-4.4.patch"
}

src_configure() {
	#$(use_with flash swf)
	# --without-swf for bug https://bugs.gentoo.org/show_bug.cgi?id=137204
	econf $(use_with emf) --without-swf $(use_with imagemagick magick) \
		  $(use_with plotutils libplot) || die 'econf failed'
}

src_compile() {
	# bug #278417
	emake -j1 || die 'compilation failed'
}

src_install () {
	emake DESTDIR="${D}" install || die 'make install failed'
	cd doc
	dodoc readme.txt || die
	dohtml *.htm || die
	doman pstoedit.1 || die
}
