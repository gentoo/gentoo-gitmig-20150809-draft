# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ogmtools/ogmtools-1.0.3.ebuild,v 1.4 2004/03/21 08:25:46 eradicator Exp $

IUSE="dvd"

DESCRIPTION="These tools allow information about (ogminfo) or extraction from (ogmdemux) or creation of (ogmmerge) OGG media streams."
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
HOMEPAGE="http://www.bunkus.org/videotools/ogmtools/"
SRC_URI="http://www.bunkus.org/videotools/${PN}/${P}.tar.bz2"

RDEPEND="dvd? ( media-libs/libdvdread )
	 media-sound/vorbis-tools"

DEPEND="${RDEPEND}
	>=sys-devel/automake-1.6.0"


src_compile() {
	econf `use_with dvd dvdread` || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dobin ogmmerge ogmdemux ogminfo ogmsplit ogmcat
	use dvd && dobin dvdxchap
	dodoc INSTALL TODO README COPYING ChangeLog
	doman dvdxchap.1  ogmcat.1  ogmdemux.1  ogminfo.1  ogmmerge.1  ogmsplit.1
}
