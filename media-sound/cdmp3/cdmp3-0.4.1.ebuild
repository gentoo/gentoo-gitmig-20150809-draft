# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdmp3/cdmp3-0.4.1.ebuild,v 1.1 2003/11/26 02:07:38 mkennedy Exp $

DESCRIPTION="Conveniently rip audio CDs to MP3 or OGG files."
HOMEPAGE="http://www.roland-riegel.de/cdmp3/index_en.html"
SRC_URI="http://www.roland-riegel.de/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
DEPEND="media-sound/cdparanoia
	app-cdr/cdrtools
	media-sound/lame
	media-sound/vorbis-tools
	dev-perl/CDDB_get
	app-misc/bfr"

S=${WORKDIR}/${P}

src_install() {
	dodoc LICENSE README AUTHORS ChangeLog
	dobin cdmp3 get_cddb
	dosym /usr/bin/cdmp3 /usr/bin/cdogg
}
