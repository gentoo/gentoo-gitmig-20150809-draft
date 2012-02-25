# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/recoverjpeg/recoverjpeg-2.0-r1.ebuild,v 1.2 2012/02/25 21:50:18 ago Exp $

EAPI=4

inherit base

DESCRIPTION="Recover JPEG pictures from a possibly corrupted disk image"
HOMEPAGE="http://www.rfc1149.net/devel/recoverjpeg"
SRC_URI="http://www.rfc1149.net/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND="media-gfx/exif
	|| ( media-gfx/imagemagick media-gfx/graphicsmagick[imagemagick] )"
RDEPEND="${DEPEND}"

DOCS=( README )
