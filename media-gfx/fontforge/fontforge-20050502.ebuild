# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fontforge/fontforge-20050502.ebuild,v 1.4 2005/08/23 20:29:40 gustavoz Exp $

inherit flag-o-matic eutils

DESCRIPTION="postscript font editor and converter"
HOMEPAGE="http://fontforge.sourceforge.net/"
SRC_URI="http://fontforge.sourceforge.net/${PN}_full-${PV}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ppc sparc x86"
IUSE="png gif jpeg tiff truetype svg unicode X"

DEPEND="png? ( >=media-libs/libpng-1.2.4 )
	gif? ( >=media-libs/giflib-4.1.0-r1 )
	jpeg? ( >=media-libs/jpeg-6b-r2 )
	tiff? ( >=media-libs/tiff-3.5.7-r1 )
	truetype? ( >=media-libs/freetype-2.1.4 )
	svg? ( >=dev-libs/libxml2-2.6.7 )
	unicode? ( >=media-libs/libuninameslist-030713 )
	!media-gfx/pfaedit"

src_compile() {
	sed -i -e "s@ungif@gif@g" configure* || die
	sed -i -e 's@"libungif"@"libgif"@g' gdraw/gimagereadgif.c || die
	local myconf="--with-multilayer"
	use X || myconf="--without-x"

	filter-mfpmath "sse" "387"

	econf ${myconf} --without-freetype-src || die "econf failed"
	make || die
}

src_install() {
	# make install fails if this directory doesn't exist
	dodir /usr/lib
	einstall || die
	dodoc AUTHORS README*
}
