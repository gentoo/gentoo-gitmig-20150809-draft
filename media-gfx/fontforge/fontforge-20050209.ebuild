# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fontforge/fontforge-20050209.ebuild,v 1.1 2005/02/19 10:04:20 usata Exp $

inherit flag-o-matic eutils

DESCRIPTION="postscript font editor and converter"
HOMEPAGE="http://fontforge.sourceforge.net/"
SRC_URI="mirror://sourceforge/fontforge/${PN}_full-${PV}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc ~ia64 ~alpha"
IUSE="png gif jpeg tiff truetype svg unicode X"

DEPEND="png? ( >=media-libs/libpng-1.2.4 )
	gif? ( >=media-libs/libungif-4.1.0-r1 )
	jpeg? ( >=media-libs/jpeg-6b-r2 )
	tiff? ( >=media-libs/tiff-3.5.7-r1 )
	truetype? ( >=media-libs/freetype-2.1.4 )
	svg? ( >=dev-libs/libxml2-2.6.7 )
	unicode? ( >=media-libs/libuninameslist-030713 )
	!media-gfx/pfaedit"

src_compile() {
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

pkg_postinst() {
	einfo
	einfo "If you want to do autotracing you should install either"
	einfo "media-gfx/autotrace or media-gfx/potrace."
	einfo
}
