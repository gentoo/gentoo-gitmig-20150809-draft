# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/qrencode/qrencode-3.2.0.ebuild,v 1.2 2012/04/01 07:43:41 scarabeus Exp $

EAPI=4

AUTOTOOLS_AUTORECONF=true

inherit autotools-utils

DESCRIPTION="C library for encoding data in a QR Code symbol"
HOMEPAGE="http://fukuchi.org/works/qrencode/"
SRC_URI="http://fukuchi.org/works/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE=""

RDEPEND="media-libs/libpng"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

PATCHES=( "${FILESDIR}/${P}-pngregenfix.patch" )
