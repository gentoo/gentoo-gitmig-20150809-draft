# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kino/kino-0.8.1.ebuild,v 1.2 2006/05/29 21:58:12 calchan Exp $

inherit eutils

DESCRIPTION="Kino is a non-linear DV editor for GNU/Linux"
HOMEPAGE="http://kino.schirmacher.de/"
SRC_URI="mirror://sourceforge/kino/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="alsa dvdr ffmpeg quicktime"

DEPEND=">=x11-libs/gtk+-2.6.0
	>=gnome-base/libglade-2.5.0
	>=dev-libs/glib-2
	dev-libs/libxml2
	media-libs/audiofile
	>=sys-libs/libraw1394-1.0.0
	>=sys-libs/libavc1394-0.4.1
	>=media-libs/libdv-0.103
	media-libs/libsamplerate
	media-video/mjpegtools
	media-sound/rawrec
	alsa? ( >=media-libs/alsa-lib-1.0.9 )
	ffmpeg? ( media-video/ffmpeg )
	quicktime? ( || ( >=media-libs/libquicktime-0.9.5 media-video/cinelerra-cvs ) )
	dvdr? ( media-video/dvdauthor )"

RESTRICT="primaryuri"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Shameful hack to link with --as-needed
	epatch ${FILESDIR}/${P}-as-needed.patch || die "epatch failed!"

	# Deactivating automagic alsa configuration, bug #134725
	if ! use alsa ; then
		epatch ${FILESDIR}/${P}-alsa.patch || die "epatch failed!"
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
