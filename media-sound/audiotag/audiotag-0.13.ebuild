# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audiotag/audiotag-0.13.ebuild,v 1.4 2004/11/22 17:01:52 corsair Exp $

IUSE="flac oggvorbis"

DESCRIPTION="A command-line audio file meta-data tagger. Sets id3 and/or vorbis tags in mp3, ogg, and flac files."
HOMEPAGE="http://tempestgames.com/ryan/"
SRC_URI="http://tempestgames.com/ryan/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~ppc64"

DEPEND="dev-lang/perl"

RDEPEND="flac? ( media-libs/flac )
	oggvorbis? ( media-sound/vorbis-tools )
	media-libs/id3lib"

src_install() {
	dobin audiotag
	dodoc README ChangeLog
}

