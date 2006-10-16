# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fontforge/fontforge-20060703-r1.ebuild,v 1.10 2006/10/16 23:55:50 vapier Exp $

inherit flag-o-matic eutils

DESCRIPTION="postscript font editor and converter"
HOMEPAGE="http://fontforge.sourceforge.net/"
SRC_URI="mirror://sourceforge/fontforge/${PN}_full-${PV}.tar.bz2
	mirror://gentoo/cidmaps-20041222.tgz"	# http://fontforge.sf.net/cidmaps.tgz

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ~ppc-macos ppc64 sparc x86"
IUSE="png gif jpeg tiff truetype svg unicode X"

DEPEND="png? ( >=media-libs/libpng-1.2.4 )
	gif? ( >=media-libs/giflib-4.1.0-r1 )
	jpeg? ( >=media-libs/jpeg-6b-r2 )
	tiff? ( >=media-libs/tiff-3.5.7-r1 )
	truetype? ( >=media-libs/freetype-2.1.4 )
	svg? ( >=dev-libs/libxml2-2.6.7 )
	unicode? ( >=media-libs/libuninameslist-030713 )
	!media-gfx/pfaedit"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e 's:ungif:gif:g' configure* || die
	sed -i -e 's:"libungif":"libgif":g' gdraw/gimagereadgif.c || die
	use ia64 && epatch "${FILESDIR}/${PN}-20060406-ia64.patch"
}

src_compile() {
	filter-mfpmath "sse" "387"

	econf \
		--with-multilayer \
		--without-freetype-src \
		$(use_with X x) \
		|| die "econf failed"
	make || die
}

src_install() {
	einstall || die
	dodoc AUTHORS README*

	# install cidmaps needed for editing fonts with lots of characters #129518
	insinto /usr/share/fontforge
	doins "${WORKDIR}"/*.cidmap
}
