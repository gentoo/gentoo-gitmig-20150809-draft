# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/autotrace/autotrace-0.31.1-r2.ebuild,v 1.1 2007/01/20 14:18:14 vapier Exp $

inherit eutils autotools

DESCRIPTION="Converts Bitmaps to vector-graphics"
SRC_URI="mirror://sourceforge/autotrace/${P}.tar.gz"
HOMEPAGE="http://autotrace.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="flash imagemagick pdf png"

DEPEND="media-libs/libexif
	pdf? ( media-gfx/pstoedit )
	png? ( >=media-libs/libpng-1.2.5-r4 )
	flash? ( >=media-libs/ming-0.2a )
	imagemagick? ( >=media-gfx/imagemagick-5.5.6-r1 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-m4.patch
	epatch "${FILESDIR}"/${P}-libs.patch
	epatch "${FILESDIR}"/${PN}-imagemagick.patch
	use pdf || echo 'AC_DEFUN([AM_PATH_PSTOEDIT],[$3])' > acinclude.m4
	eautoreconf
}

src_compile() {
	econf \
		$(use_with imagemagick magick) \
		$(use_with pdf pstoedit) \
		|| die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
