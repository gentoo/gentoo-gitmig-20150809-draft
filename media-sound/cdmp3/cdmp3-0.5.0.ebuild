# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdmp3/cdmp3-0.5.0.ebuild,v 1.6 2008/11/30 07:05:34 ssuominen Exp $

DESCRIPTION="Conveniently rip audio CDs to MP3 or OGG files."
HOMEPAGE="http://www.roland-riegel.de/cdmp3/index.html"
SRC_URI="http://www.roland-riegel.de/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="dev-lang/perl
	media-sound/cdparanoia
	media-sound/lame
	media-sound/vorbis-tools
	dev-perl/CDDB_get
	app-misc/bfr
	virtual/cdrtools"
DEPEND=""

src_install() {
	dobin ${PN} || die "dobin failed."
	dosym /usr/bin/${PN} /usr/bin/cdogg || die "dosym failed."
	dodoc AUTHORS ChangeLog README
}
