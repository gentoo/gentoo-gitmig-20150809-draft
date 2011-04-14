# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ffmpeg2theora/ffmpeg2theora-0.25.ebuild,v 1.7 2011/04/14 12:34:56 scarabeus Exp $

EAPI="2"

inherit eutils

DESCRIPTION="A simple converter to create Ogg Theora files."
HOMEPAGE="http://v2v.cc/~j/ffmpeg2theora/index.html"
SRC_URI="http://v2v.cc/~j/ffmpeg2theora/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE="debug kate"

RDEPEND="virtual/ffmpeg
	>=media-libs/libvorbis-1.1
	>=media-libs/libogg-1.1
	>=media-libs/libtheora-1.1.0[encode]
	kate? ( media-libs/libkate )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/scons-1.0.0"

src_compile() {
	scons_vars=(APPEND_CFLAGS="${CFLAGS}" \
		APPEND_LINKFLAGS="${LDFLAGS}" \
		debug=$(use debug && echo 1 || echo 0) \
		libkate=$(use kate && echo 1 || echo 0))
	scons "${scons_vars[@]}" || die "scons failed"
}

src_install() {
	scons "${scons_vars[@]}" destdir="${D}" prefix=/usr mandir=PREFIX/share/man install || die "install failed"
	dodoc AUTHORS ChangeLog README TODO || die
}
