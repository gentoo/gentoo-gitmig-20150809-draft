# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pfaedit/pfaedit-030420.ebuild,v 1.1 2003/04/25 14:42:04 utx Exp $

inherit flag-o-matic

S="${WORKDIR}/${PN}"
DESCRIPTION="postscript font editor and converter"
SRC_URI="http://pfaedit.sourceforge.net/pfaedit_full-${PV}.tgz"
HOMEPAGE="http://pfaedit.sourceforge.net/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86"
IUSE="png gif jpeg tiff truetype X"

DEPEND="png? ( >=media-libs/libpng-1.2.4 )
	gif? ( >=media-libs/libungif-4.1.0-r1 )
	jpeg? ( >=media-libs/jpeg-6b-r2 )
	tiff? ( >=media-libs/tiff-3.5.7-r1 )
	truetype? ( >=media-libs/freetype-2.1.2 )"

src_compile() {
	local myconf=""
	use X || myconf="--without-x"
	
	filter-flags -mfpmath=sse -mfpmath=sse,387
	
	econf ${myconf} --without-freetype-src
	make || die
}

src_install() {
	# make install fails if this directory doesn't exist
	dodir /usr/lib
	einstall
	dodoc AUTHORS COPYING LICENSE README 
}
