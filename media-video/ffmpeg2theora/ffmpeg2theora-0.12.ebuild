# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ffmpeg2theora/ffmpeg2theora-0.12.ebuild,v 1.1 2005/02/08 16:52:25 kzimmerm Exp $

DESCRIPTION="A simple converter to create Ogg Theora files."
HOMEPAGE="http://www.v2v.cc/~j/ffmpeg2theora/"
SRC_URI="http://www.v2v.cc/~j/ffmpeg2theora/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=media-video/ffmpeg-0.4.9_pre1
	>=media-libs/libvorbis-1.1
	>=media-libs/libogg-1.1
	>=media-libs/libtheora-1.0_alpha4"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	make DESTDIR=${D} install
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
