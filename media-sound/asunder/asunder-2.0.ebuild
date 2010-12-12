# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/asunder/asunder-2.0.ebuild,v 1.2 2010/12/12 17:39:41 fauli Exp $

EAPI=2

DESCRIPTION="a graphical Audio CD ripper and encoder with support for WAV, MP3, OggVorbis and FLAC."
HOMEPAGE="http://littlesvr.ca/asunder/"
SRC_URI="http://littlesvr.ca/${PN}/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="flac mp3 vorbis wavpack"

COMMON_DEPEND="x11-libs/gtk+:2
	>=media-libs/libcddb-0.9.5
	media-sound/cdparanoia"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"
RDEPEND="${COMMON_DEPEND}
	mp3? ( media-sound/lame )
	vorbis? ( media-sound/vorbis-tools )
	flac? ( media-libs/flac )
	wavpack? ( media-sound/wavpack )"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
