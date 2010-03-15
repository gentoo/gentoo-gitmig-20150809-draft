# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/recoverjpeg/recoverjpeg-2.0.ebuild,v 1.1 2010/03/15 13:30:10 ssuominen Exp $

EAPI=2

DESCRIPTION="Recover JPEG pictures from a possibly corrupted disk image"
HOMEPAGE="http://www.rfc1149.net/devel/recoverjpeg"
SRC_URI="http://www.rfc1149.net/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="minimal"

RDEPEND="!minimal? ( media-gfx/exif
	media-gfx/imagemagick
	dev-lang/python )"

src_configure() {
	econf \
		--disable-dependency-tracking
}

src_install() {
	if use minimal; then
		dobin recover{jpeg,mov} || die
		doman recover{jpeg,mov}.1 || die
	else
		emake DESTDIR="${D}" install || die
	fi

	dodoc README
}
