# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kino/kino-0.8.0.ebuild,v 1.1 2006/03/28 07:03:02 morfic Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Kino is a non-linear DV editor for GNU/Linux"
HOMEPAGE="http://kino.schirmacher.de/"
SRC_URI="mirror://sourceforge/kino/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"
IUSE="quicktime dvdr ffmpeg"

# Will use ALSA if alsa-lib>=1.0.9, but I haven't added a USE flag
# to turn this off explicitly as if you don't want it, don't install it!

DEPEND=">=x11-libs/gtk+-2.6.0
	>=gnome-base/libglade-2.5.0
	>=dev-libs/glib-2
	dev-libs/libxml2
	media-libs/audiofile
	media-sound/esound
	>=sys-libs/libraw1394-1.0.0
	>=sys-libs/libavc1394-0.4.1
	>=media-libs/libdv-0.103
	media-libs/libsamplerate
	media-video/mjpegtools
	media-sound/rawrec
	ffmpeg? ( media-video/ffmpeg )
	quicktime? ( || ( >=media-libs/libquicktime-0.9.5 media-video/cinelerra-cvs ) )
	dvdr? ( media-video/dvdauthor )"

RESTRICT="primaryuri"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Fix the quicktime and avcodec/ffmpeg logic in configure.in
	epatch ${FILESDIR}/${P}-configure.diff
	# Fix for the checking for dirname... no configure error
	epatch ${FILESDIR}/${P}-configure-in.diff
	einfo "Running autoconf..."
	autoconf
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
