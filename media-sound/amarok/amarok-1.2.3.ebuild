# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/amarok/amarok-1.2.3.ebuild,v 1.2 2005/04/03 19:25:04 greg_g Exp $

inherit kde eutils

DESCRIPTION="amaroK - the audio player for KDE"
HOMEPAGE="http://amarok.kde.org/"
SRC_URI="mirror://sourceforge/amarok/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc -sparc ~x86"
IUSE="arts flac gstreamer kde mad mysql noamazon oggvorbis opengl xine xmms visualization"
# kde: enables compilation of the konqueror sidebar plugin

RDEPEND="kde? ( || ( kde-base/konqueror kde-base/kdebase ) )
	 arts? ( kde-base/arts
		 || ( ( kde-base/kdemultimedia-arts kde-base/akode )
		 	kde-base/kdemultimedia ) )
	 opengl? ( virtual/opengl )
	 xmms? ( >=media-sound/xmms-1.2 )
	 xine? ( >=media-libs/xine-lib-1_rc4 )
	 >=media-libs/tunepimp-0.3.0
	 >=media-libs/taglib-1.3.1
	 gstreamer? ( >=media-libs/gst-plugins-0.8.6
	 	      mad? ( >=media-plugins/gst-plugins-mad-0.8.6 )
		      oggvorbis? ( >=media-plugins/gst-plugins-ogg-0.8.6
				   >=media-plugins/gst-plugins-vorbis-0.8.6 )
		      flac? ( >=media-plugins/gst-plugins-flac-0.8.6 ) )
	 mysql? ( >=dev-db/mysql-4 )
	 visualization? ( media-libs/libsdl
			  >=media-plugins/libvisual-plugins-0.2 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9.0"

need-kde 3.2

pkg_setup() {
	if use arts && ! use xine && ! use gstreamer; then
		ewarn "aRts support is deprecated, if you have problems please consider"
		ewarn "enabling support for Xine or GStreamer"
		ewarn "(emerge amarok again with USE=\"xine\" or USE=\"gstreamer\")."
		ebeep 2
	fi

	if ! use arts && ! use xine && ! use gstreamer; then
		eerror "amaroK needs either aRts (deprecated), Xine or GStreamer to work,"
		eerror "please try again with USE=\"arts\", USE=\"xine\" or USE=\"gstreamer\"."
		die
	fi

	# check whether kdelibs was compiled with arts support
	kde_pkg_setup
}

src_compile() {
	# amarok does not respect kde coding standards, and makes a lot of
	# assuptions regarding its installation directory. For this reason,
	# it must be installed in the KDE install directory.
	PREFIX="`kde-config --prefix`"

	myconf="$(use_with arts) $(use_with xine)
		$(use_with gstreamer) $(use_enable mysql)
		$(use_with opengl) $(use_enable !noamazon amazon)"

	kde_src_compile
}
