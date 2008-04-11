# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kdenlive/kdenlive-0.5.ebuild,v 1.4 2008/04/11 13:40:15 aballier Exp $

inherit eutils kde

DESCRIPTION="Kdenlive! (pronounced Kay-den-live) is a Non Linear Video Editing Suite for KDE."
HOMEPAGE="http://kdenlive.sourceforge.net/"
SRC_URI="mirror://sourceforge/kdenlive/${P}-1.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

RDEPEND="media-video/ffmpeg
	>=media-libs/mlt-0.2.4-r1
	>=media-libs/mlt++-0.2.2"

DEPEND="${RDEPEND}
	x11-base/xorg-server
	x11-proto/xextproto"

need-kde 3

pkg_setup() {
	if ! built_with_use media-libs/mlt sdl || \
		! built_with_use media-video/ffmpeg sdl ; then
			eerror "You need to build both media-libs/mlt with USE='sdl'"
			die "media-libs/mlt or media-video/ffmpeg without sdl detected"
	fi

	if ! built_with_use media-video/ffmpeg X ; then
		eerror "You need to build media-video/ffmpeg with USE='X'"
		die "media-video/ffmpeg without X detected"
	fi
}

src_unpack() {
	kde_src_unpack
	epatch "${FILESDIR}/${P}-ffmpegheaders.patch"
	epatch "${FILESDIR}/${P}-gcc-4.3.patch"
	rm -f configure
}

src_compile() {
	myconf="--enable-pch"

	kde_src_compile
}

src_install() {
	kde_src_install

	# docbook is not generated, does not build properly
	# and is installed to the wrong location
	rm -r "${D}"/usr/share/doc/HTML
}
