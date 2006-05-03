# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ffmpeg2theora/ffmpeg2theora-0.16.ebuild,v 1.2 2006/05/03 02:52:12 weeve Exp $

inherit eutils

DESCRIPTION="A simple converter to create Ogg Theora files."
HOMEPAGE="http://www.v2v.cc/~j/ffmpeg2theora/"
SRC_URI="http://www.v2v.cc/~j/ffmpeg2theora/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=media-video/ffmpeg-0.4.9_pre20051120
	>=media-libs/libvorbis-1.1
	>=media-libs/libogg-1.1
	>=media-libs/libtheora-1.0_alpha4-r1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	if ! built_with_use media-libs/libtheora encode; then
		einfo "ffmpeg2theora needs libtheora compiled with encode in USE."
		die "libtheora built without encoding support."
	fi
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
