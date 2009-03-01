# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ffmpeg2theora/ffmpeg2theora-0.23.ebuild,v 1.1 2009/03/01 13:00:15 patrick Exp $

EAPI="2"

inherit eutils

DESCRIPTION="A simple converter to create Ogg Theora files."
HOMEPAGE="http://www.v2v.cc/~j/ffmpeg2theora/index.html"
SRC_URI="http://www.v2v.cc/~j/ffmpeg2theora/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-video/ffmpeg-0.4.9_p20070616-r20[vhook]
	>=media-libs/libvorbis-1.1
	>=media-libs/libogg-1.1
	>=media-libs/libtheora-1.0_beta1[encode]
	media-libs/libkate"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/scons-1.0.0"

src_compile() {
	scons APPEND_CFLAGS="${CFLAGS}" APPEND_LINKFLAGS="${LDFLAGS}" || die "scons failed"
}

src_install() {
	scons destdir="${D}" prefix=/usr install || die "install failed"
	dodoc AUTHORS ChangeLog README TODO || die
#	newdoc kino_export/README README.kino_export
#	exeinto /usr/share/kino/scripts/exports
#	doexe kino_export/ffmpeg2theora.sh
}
