# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audiotag/audiotag-0.17.ebuild,v 1.1 2008/02/15 12:47:17 drac Exp $

inherit eutils

DESCRIPTION="a command-line tool for mass tagging/renaming of audio files."
HOMEPAGE="http://www.tempestgames.com/ryan"
SRC_URI="http://tempestgames.com/ryan/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="aac flac mp3 vorbis"

RDEPEND="flac? ( media-libs/flac )
	 vorbis? ( media-sound/vorbis-tools )
	 mp3? ( media-libs/id3lib )
	 aac? ( media-video/atomicparsley )"
DEPEND="dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-metaflac-parameters.patch
}

src_install() {
	dobin ${PN}
	dodoc ChangeLog README
}
