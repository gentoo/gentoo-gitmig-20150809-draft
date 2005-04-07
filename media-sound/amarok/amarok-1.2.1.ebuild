# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/amarok/amarok-1.2.1.ebuild,v 1.3 2005/04/07 15:50:59 blubb Exp $

inherit kde eutils

DESCRIPTION="amaroK - the audio player for KDE"
HOMEPAGE="http://amarok.kde.org/"
SRC_URI="mirror://sourceforge/amarok/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"

IUSE="noamazon xmms opengl xine kde arts gstreamer mysql"
# kde: enables compilation of the konqueror sidebar plugin

KEYWORDS="amd64 ~ppc -sparc x86"

#	Not yet released:
#	">=media-libs/libvisual-0.2.0
RDEPEND="kde? ( || ( kde-base/konqueror kde-base/kdebase ) )
	 arts? ( kde-base/arts
		 || ( kde-base/kdemultimedia-arts kde-base/kdemultimedia )
		 || ( kde-base/akode kde-base/kdemultimedia ) )
	 opengl? ( virtual/opengl )
	 xmms? ( >=media-sound/xmms-1.2 )
	 xine? ( >=media-libs/xine-lib-1_rc4 )
	 >=media-libs/tunepimp-0.3.0
	 >=media-libs/taglib-1.3.1
	 gstreamer? ( >=media-libs/gst-plugins-0.8.6
	 	      >=media-plugins/gst-plugins-mad-0.8.6 )
	 mysql? ( >=dev-db/mysql-4 )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9.0"

need-kde 3.2

pkg_setup() {
	if use !xine && use !arts && use !gstreamer
	then
		die "You must enable either aRts or Xine or GStreamer"
	fi
}

src_compile() {
	# amarok does not respect kde coding standards, and makes a lot of
	# assuptions regarding its installation directory. For this reason,
	# it must be installed in the KDE install directory.
	PREFIX="`kde-config --prefix`"

	myconf="$(use_with arts) $(use_with xine) $(use_with gstreamer) $(use_enable mysql) \
		$(use_with opengl) $(use_enable !noamazon amazon)"

	kde_src_compile
}
