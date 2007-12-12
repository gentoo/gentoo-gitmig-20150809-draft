# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/dir2ogg/dir2ogg-0.11.ebuild,v 1.1 2007/12/12 17:33:32 drac Exp $

inherit eutils versionator

MY_PR=$(get_version_component_range 1-2 ${PV})

DESCRIPTION="Converts Mp3, M4a, Wma, and Wav files to Ogg Vorbis format."
HOMEPAGE="http://jak-linux.org/projects/dir2ogg"
SRC_URI="http://jak-linux.org/projects/${PN}/${MY_PR}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="aac wma"

DEPEND=""
RDEPEND="virtual/python
	dev-python/pyid3lib
	media-sound/vorbis-tools
	>=media-libs/mutagen-1.11
	|| ( media-sound/mpg123 media-sound/mpg321 )
	aac? ( media-libs/faad2 )
	wma? ( media-video/mplayer )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-u1-01wav.patch
}

src_install() {
	dobin dir2ogg
	doman dir2ogg.1
	dodoc NEWS README
}
