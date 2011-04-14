# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ffmpeg2theora/ffmpeg2theora-0.26.ebuild,v 1.2 2011/04/14 12:34:56 scarabeus Exp $

EAPI=2

DESCRIPTION="A simple converter to create Ogg Theora files."
HOMEPAGE="http://www.v2v.cc/~j/ffmpeg2theora/"
SRC_URI="http://www.v2v.cc/~j/${PN}/downloads/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug kate"

RDEPEND="virtual/ffmpeg
	>=media-libs/libvorbis-1.1
	>=media-libs/libogg-1.1
	>=media-libs/libtheora-1.1[encode]
	kate? ( >=media-libs/libkate-0.3.7 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/scons-1"

src_compile() {
	scons_vars=(
		APPEND_CCFLAGS="${CFLAGS}" \
		APPEND_LINKFLAGS="${LDFLAGS}" \
		debug=$(use debug && echo 1 || echo 0) \
		libkate=$(use kate && echo 1 || echo 0)
		)

	scons "${scons_vars[@]}" || die
}

src_install() {
	scons "${scons_vars[@]}" destdir="${D}" prefix=/usr \
		mandir=PREFIX/share/man install || die

	dodoc AUTHORS ChangeLog README subtitles.txt TODO
}
