# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kino/kino-0.9.0.ebuild,v 1.4 2006/08/11 02:24:10 josejx Exp $

inherit eutils

DESCRIPTION="Kino is a non-linear DV editor for GNU/Linux"
HOMEPAGE="http://kino.schirmacher.de/"
SRC_URI="mirror://sourceforge/kino/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="alsa dvdr ffmpeg quicktime sox vorbis"

DEPEND=">=x11-libs/gtk+-2.6.0
	>=gnome-base/libglade-2.5.0
	>=dev-libs/glib-2
	dev-libs/libxml2
	media-libs/audiofile
	>=sys-libs/libraw1394-1.0.0
	>=sys-libs/libavc1394-0.4.1
	>=media-libs/libdv-0.103
	media-libs/libsamplerate
	!sparc? ( media-libs/libiec61883 )
	alsa? ( >=media-libs/alsa-lib-1.0.9 )
	ffmpeg? ( >=media-video/ffmpeg-0.4.9_p20051216 )
	quicktime? ( || ( >=media-libs/libquicktime-0.9.5 media-video/cinelerra-cvs ) )"
RDEPEND="${DEPEND}
	media-video/mjpegtools
	media-sound/rawrec
	dvdr? ( media-video/dvdauthor )
	sox? ( media-sound/sox )
	vorbis? ( media-sound/vorbis-tools )"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Fix to link with --as-needed
	sed -i -e 's:LIBS="-lXext:LIBS="-lXext -lX11:' configure || die "sed failed!"

	# Deactivating automagic alsa configuration, bug #134725
	if ! use alsa ; then
		sed -i -e "s:HAVE_ALSA 1:HAVE_ALSA 0:" configure || die "sed failed!"
	fi

	epatch ${FILESDIR}/${P}-compile-fix.patch
}

src_compile() {
	econf \
		--disable-dependency-tracking \
		--disable-debug \
		$(use_enable quicktime) \
		$(use_with ffmpeg avcodec) || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
}
