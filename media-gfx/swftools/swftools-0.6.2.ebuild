# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/swftools/swftools-0.6.2.ebuild,v 1.3 2005/12/11 19:23:51 vanquirius Exp $

inherit eutils

DESCRIPTION="SWF Tools is a collection of SWF manipulation and generation utilities"
HOMEPAGE="http://www.quiss.org/swftools/"
SRC_URI="http://www.quiss.org/swftools/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE="avi"

DEPEND=">=media-libs/t1lib-1.3.1
		media-libs/freetype
		media-libs/jpeg
		avi? ( media-video/avifile )"
RDEPEND=""

src_install() {
	einstall || die "Install died."
	dodoc AUTHORS ChangeLog FAQ TODO
}
