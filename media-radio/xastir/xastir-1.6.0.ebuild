# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/xastir/xastir-1.6.0.ebuild,v 1.2 2006/06/16 23:06:12 mr_bones_ Exp $

DESCRIPTION="A program for receiving and plotting APRS(tm) position packets"
HOMEPAGE="http://xastir.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="imagemagick curl ax25 festival shape"

DEPEND="virtual/libc
	x11-libs/openmotif
	ax25? ( dev-libs/libax25
		media-radio/ax25-apps
		media-radio/ax25-tools )
	festival? ( app-accessibility/festival )
	shape? ( sci-libs/shapelib
		dev-libs/libpcre )
	imagemagick? ( media-gfx/imagemagick )
	curl? ( net-misc/curl )"

src_install() {
	make DESTDIR="${D}" install || die
	mkdir -p "${D}"/usr/local
	dosym ../xastir usr/local/xastir
}
