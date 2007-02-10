# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/moodbar/moodbar-0.1.2.ebuild,v 1.1 2007/02/10 23:35:12 hanno Exp $

DESCRIPTION="The moodbar tool and gstreamer plugin for Amarok"
HOMEPAGE="http://amarok.kde.org/wiki/Moodbar"
SRC_URI="http://pwsp.net/~qbob/moodbar-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mp3 ogg vorbis flac"

DEPEND=">=media-libs/gst-plugins-base-0.10
	>=sci-libs/fftw-3.0"
RDEPEND="${DEPEND}
	>=media-libs/gst-plugins-good-0.10
	mp3? ( >=media-plugins/gst-plugins-mad-0.10 )
	ogg? ( >=media-plugins/gst-plugins-ogg-0.10 )
	vorbis? ( >=media-plugins/gst-plugins-vorbis-0.10 )
	flac? ( >=media-plugins/gst-plugins-flac-0.10 )"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
}
