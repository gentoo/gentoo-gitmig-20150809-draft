# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/autotrace/autotrace-0.31.1-r1.ebuild,v 1.17 2006/03/27 21:32:14 agriffis Exp $

inherit eutils

DESCRIPTION="Converts Bitmaps to vector-graphics"
SRC_URI="mirror://sourceforge/autotrace/${P}.tar.gz"
HOMEPAGE="http://autotrace.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 alpha ppc amd64 sparc ia64"
IUSE="png flash imagemagick"

DEPEND="media-libs/libexif
	png? ( >=media-libs/libpng-1.2.5-r4 )
	flash? ( >=media-libs/ming-0.2a )
	imagemagick? ( >=media-gfx/imagemagick-5.5.6-r1 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-m4.patch
	epatch "${FILESDIR}"/${PN}-imagemagick.patch
	autoconf || die
}

src_compile() {
	local myconf=""
	use imagemagick || myconf="--without-magick"
	econf ${myconf} --without-pstoedit || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
