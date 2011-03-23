# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kino/kino-1.3.3.ebuild,v 1.7 2011/03/23 08:36:47 radhermit Exp $

EAPI=1

inherit eutils

DESCRIPTION="Kino is a non-linear DV editor for GNU/Linux"
HOMEPAGE="http://www.kinodv.org/"
SRC_URI="mirror://sourceforge/kino/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE="alsa dvdr gpac lame gstreamer quicktime sox vorbis"

# This ebuild would benefit a lot of USE dependencies but that has to wait for
# EAPI 2. The usual fix is to issue built_with_use checks but in that particu-
# lar case it would make the ebuild rather complicated to write and maintain
# (certain features can be enabled in various different ways). Also it would
# also force the emerge process to stop a bit too often for users not to comp-
# lain. Thus, if you need features like theora, x264, xvid and maybe others,
# make sure you activate the required support where it should be (ffmpeg, mostly).

# Optional dependency on cinelerra-cvs (as a replacement for libquicktime)
# dropped because kino may run with it but won't build anymore.

DEPEND=">=x11-libs/gtk+-2.6.0:2
	>=gnome-base/libglade-2.5.0
	>=dev-libs/glib-2
	x11-libs/libXv
	dev-libs/libxml2
	dev-util/intltool
	media-libs/audiofile
	>=sys-libs/libraw1394-1.0.0
	>=sys-libs/libavc1394-0.4.1
	>=media-libs/libdv-0.103
	media-libs/libsamplerate
	media-libs/libiec61883
	alsa? ( >=media-libs/alsa-lib-1.0.9 )
	>=media-video/ffmpeg-0.4.9_p20080326
	quicktime? ( >=media-libs/libquicktime-0.9.5 )"
RDEPEND="${DEPEND}
	media-video/mjpegtools
	media-sound/rawrec
	dvdr? ( media-video/dvdauthor
		app-cdr/dvd+rw-tools )
	gpac? ( media-video/gpac )
	lame? ( media-sound/lame )
	gstreamer? ( media-libs/gst-plugins-base )
	sox? ( media-sound/sox )
	vorbis? ( media-sound/vorbis-tools )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix to link with --as-needed
	sed -i -e 's:LIBS="-lXext:LIBS="-lXext -lX11:' configure || die "sed failed"

	# Deactivating automagic alsa configuration, bug #134725
	if ! use alsa ; then
		sed -i -e "s:HAVE_ALSA 1:HAVE_ALSA 0:" configure || die "sed failed"
	fi

	# Fix bug #169590
	sed -i \
		-e '/\$(LIBQUICKTIME_LIBS) \\/d' \
		-e '/^[[:space:]]*\$(SRC_LIBS)/ a\
	\$(LIBQUICKTIME_LIBS) \\' \
		src/Makefile.in || die "sed failed"

	# Fix bug #172687
	sed -i \
		-e 's/^install-exec-local:/install-exec-local: install-binPROGRAMS/' \
		src/Makefile.in || die "sed failed"

	# Fix test failure discovered in bug #193947
	sed -i -e '$a\
\
ffmpeg/libavcodec/ps2/idct_mmi.c\
ffmpeg/libavcodec/sparc/dsputil_vis.c\
ffmpeg/libavcodec/sparc/vis.h\
ffmpeg/libavutil/bswap.h\
ffmpeg/libswscale/yuv2rgb_template.c\
src/export.h\
src/message.cc\
src/page_bttv.cc' po/POTFILES.in || die "sed failed"

	sed -i -e 's:^#include <quicktime.h>:#include <lqt/quicktime.h>:' \
		src/filehandler.h || die "sed failed"

	# Fix compilation with gcc-4.3, see bug #215160
	sed -i -e '/C++ includes/ a\
#include <algorithm>' src/playlist.cc || die "sed failed"

	epatch "${FILESDIR}/${P}-avutil.patch"
}

src_compile() {
	econf \
		--disable-dependency-tracking \
		--disable-local-ffmpeg \
		$(use_enable quicktime) \
		$(use_with sparc dv1394) \
		CPPFLAGS="-I${ROOT}usr/include/libavcodec -I${ROOT}usr/include/libavformat -I${ROOT}usr/include/libswscale" \
		|| die "Configuration failed"
	emake || die "Compilation failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Installation failed"
	dodoc AUTHORS BUGS ChangeLog NEWS README* TODO
	# Fix bug #177378
	fowners root:root -R /usr/share/kino/help
}
