# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/autotrace/autotrace-0.31.1-r6.ebuild,v 1.2 2011/02/22 21:33:53 vapier Exp $

EAPI=3
inherit autotools eutils

_dpatch=15

DESCRIPTION="A program for converting bitmaps to vector graphics"
HOMEPAGE="http://packages.qa.debian.org/a/autotrace.html http://autotrace.sourceforge.net/"
SRC_URI="mirror://debian/pool/main/a/${PN}/${PN}_${PV}.orig.tar.gz
	mirror://debian/pool/main/a/${PN}/${PN}_${PV}-${_dpatch}.diff.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="+imagemagick"

RDEPEND="media-libs/libexif
	>=media-libs/libpng-1.4.3
	>=media-libs/ming-0.4.2
	>=media-gfx/pstoedit-3.50
	imagemagick? ( >=media-gfx/imagemagick-6.6.2.5 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${WORKDIR}"/${PN}_${PV}-${_dpatch}.diff

	epatch "${FILESDIR}"/${P}-{m4,libpng14,pkgconfig}.patch \
		"${FILESDIR}"/${P}-swf-output.patch \
		"${FILESDIR}"/${P}-GetOnePixel.patch \
		"${FILESDIR}"/${P}-libpng-1.5.patch

	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_with imagemagick magick) \
		--with-ming \
		--with-pstoedit
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
