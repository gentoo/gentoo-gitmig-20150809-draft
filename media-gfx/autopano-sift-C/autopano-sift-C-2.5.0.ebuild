# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/autopano-sift-C/autopano-sift-C-2.5.0.ebuild,v 1.3 2008/11/22 23:40:48 maekke Exp $

inherit cmake-utils

DESCRIPTION="SIFT algorithm for automatic panorama creation in C"
HOMEPAGE="http://hugin.sourceforge.net/ http://user.cs.tu-berlin.de/~nowozin/autopano-sift/"
SRC_URI="mirror://sourceforge/hugin/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="
	!media-gfx/autopano-sift
	dev-libs/libxml2
	media-libs/jpeg
	media-libs/libpano13
	media-libs/libpng
	media-libs/tiff
	sys-libs/zlib
	"
RDEPEND="${DEPEND}"
