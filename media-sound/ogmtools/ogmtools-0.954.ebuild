# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ogmtools/ogmtools-0.954.ebuild,v 1.3 2003/02/14 17:12:03 mholzer Exp $

IUSE=""

DESCRIPTION="These tools allow information about (ogminfo) or extraction from (ogmdemux) or creation of (ogmmerge) OGG media streams."
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
HOMEPAGE="http://www.bunkus.org/videotools/ogmtools/"
SRC_URI="http://www.bunkus.org/videotools/${PN}/${P}.tar.bz2"

DEPEND=">=sys-devel/automake-1.6.0
		media-sound/vorbis-tools"


src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	into /usr
	dobin ogmmerge ogmdemux ogminfo ogmsplit ogmcat dvdxchap
	into /usr/share
	doman man1/ogmsplit.1 man1/ogminfo.1 man1/ogmmerge.1 man1/ogmdemux.1 man1/ogmcat.1 man1/dvdxchap.1
}
