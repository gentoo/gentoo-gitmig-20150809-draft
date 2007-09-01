# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fontforge/fontforge-20070831.ebuild,v 1.1 2007/09/01 17:29:34 vapier Exp $

inherit flag-o-matic eutils

DESCRIPTION="postscript font editor and converter"
HOMEPAGE="http://fontforge.sourceforge.net/"
SRC_URI="mirror://sourceforge/fontforge/${PN}_full-${PV}.tar.bz2
	mirror://gentoo/cidmaps-20041222.tgz"	# http://fontforge.sf.net/cidmaps.tgz

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc-macos ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="gif jpeg nls png python tiff truetype svg unicode X"

RDEPEND="gif? ( >=media-libs/giflib-4.1.0-r1 )
	jpeg? ( >=media-libs/jpeg-6b-r2 )
	png? ( >=media-libs/libpng-1.2.4 )
	python? ( dev-lang/python )
	tiff? ( >=media-libs/tiff-3.5.7-r1 )
	truetype? ( >=media-libs/freetype-2.1.4 )
	svg? ( >=dev-libs/libxml2-2.6.7 )
	unicode? ( >=media-libs/libuninameslist-030713 )
	!media-gfx/pfaedit"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e 's:ungif:gif:g' configure* || die
	sed -i -e 's:"libungif":"libgif":g' gdraw/gimagereadgif.c || die
}

src_compile() {
	# no real way of disabling gettext/nls ...
	use nls || export ac_cv_header_libintl_h=no
	econf \
		--with-multilayer \
		--without-freetype-src \
		$(use_with python) \
		$(use_with X x) \
		|| die "econf failed"
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS README*

	# install cidmaps needed for editing fonts with lots of characters #129518
	insinto /usr/share/fontforge
	doins "${WORKDIR}"/*.cidmap
}
