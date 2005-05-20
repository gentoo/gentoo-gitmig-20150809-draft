# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kino/kino-0.7.5-r1.ebuild,v 1.6 2005/05/20 14:53:55 luckyduck Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Kino is a non-linear DV editor for GNU/Linux"
HOMEPAGE="http://kino.schirmacher.de/"
SRC_URI="mirror://sourceforge/kino/${P}.tar.gz"
RESTRICT="primaryuri"
IUSE="quicktime dvdr ffmpeg"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc amd64 ~ppc"

DEPEND="x11-libs/gtk+
	>=gnome-base/libglade-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libgnome-2
	>=dev-libs/glib-2
	dev-libs/libxml2
	media-libs/audiofile
	media-sound/esound
	sys-libs/libraw1394
	sys-libs/libavc1394
	>=media-libs/libdv-0.102
	media-libs/libsamplerate
	media-video/mjpegtools
	media-sound/rawrec
	ffmpeg? ( media-video/ffmpeg )
	quicktime? ( virtual/quicktime )
	dvdr? ( media-video/dvdauthor )"

src_unpack() {
	unpack ${A}
	cd ${S}
	if [[ $(tc-endian) == "big" ]] ; then
		epatch ${FILESDIR}/${P}-ppc.diff
	fi
}

src_compile() {
	econf \
		--disable-dependency-tracking \
		--disable-debug \
		$(use_with quicktime) \
		$(use_with ffmpeg avcodec) || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
}
