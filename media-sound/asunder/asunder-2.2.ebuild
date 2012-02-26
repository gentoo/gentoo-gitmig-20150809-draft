# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/asunder/asunder-2.2.ebuild,v 1.1 2012/02/26 06:54:28 ssuominen Exp $

EAPI=4

DESCRIPTION="A graphical Audio CD ripper and encoder with support for WAV, MP3, OggVorbis and FLAC"
HOMEPAGE="http://littlesvr.ca/asunder/"
SRC_URI="http://littlesvr.ca/${PN}/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="flac mp3 vorbis wavpack"

COMMON_DEPEND=">=media-libs/libcddb-0.9.5
	media-sound/cdparanoia
	x11-libs/gtk+:2"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"
RDEPEND="${COMMON_DEPEND}
	flac? ( media-libs/flac )
	mp3? ( media-sound/lame )
	vorbis? ( media-sound/vorbis-tools )
	wavpack? ( media-sound/wavpack )"

DOCS="AUTHORS ChangeLog README TODO" # NEWS is dummy
