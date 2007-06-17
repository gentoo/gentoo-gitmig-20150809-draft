# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audiotag/audiotag-0.16.ebuild,v 1.3 2007/06/17 08:14:47 corsair Exp $

IUSE="aac flac vorbis mp3"

DESCRIPTION="A command-line audio file meta-data tagger. Sets id3 and/or vorbis tags in mp3, ogg, and flac files."
HOMEPAGE="http://www.tempestgames.com/ryan/"
SRC_URI="http://tempestgames.com/ryan/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

DEPEND="dev-lang/perl"

RDEPEND="flac? ( media-libs/flac )
	 vorbis? ( media-sound/vorbis-tools )
	 mp3? ( media-libs/id3lib )
	 aac? ( media-video/atomicparsley )"

src_install() {
	dobin audiotag
	dodoc README ChangeLog
}

