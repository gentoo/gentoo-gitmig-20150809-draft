# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/freej/freej-0.8.1.ebuild,v 1.2 2007/06/24 18:04:04 peper Exp $

inherit eutils

DESCRIPTION="A unified framework for realtime video processing"
HOMEPAGE="http://freej.dyne.org/"
SRC_URI="ftp://freej.dyne.org/freej/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="v4l debug opengl jack"

DEPEND=">=media-libs/libsdl-1.2.0
	>=media-libs/libpng-1.2.0
	>=media-libs/freetype-2
	media-video/ffmpeg
	jack? ( media-sound/jack-audio-connection-kit )
	opengl? ( virtual/opengl virtual/glu )"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {

	# patch the doc path
	sed -i -e "s:doc/\${PACKAGE}-\${VERSION}:share/doc/${PF}:" Makefile.in || die "doc path patching failed!"

	econf \
	$(use_enable opengl) \
	$(use_enable v4l) \
	$(use_enable debug) \
	$(use_enable jack) \
	|| die "econf failed!"

	# give us custom CFLAGS
	sed -i \
	-e "s:^CFLAGS = .*:CFLAGS = -D_REENTRANT ${CFLAGS}:" \
	-e "s:^CXXFLAGS = .*:CXXFLAGS = -D_REENTRANT ${CXXFLAGS}:" ${S}/src/Makefile \
	|| die "Could not patch custom CFLAGS!"

	emake || die "emake failed"
}

src_install() {
	einstall || die
	dodoc FreeJ_Tutorial.pdf
}
