# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/amarok/amarok-1.2_beta4.ebuild,v 1.1 2005/02/01 15:08:05 greg_g Exp $

inherit kde eutils

MY_P="${P/_/-}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="amaroK is a media player for KDE"
HOMEPAGE="http://amarok.kde.org/"
SRC_URI="mirror://sourceforge/amarok/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"

IUSE="noamazon cjk xmms opengl xine kde arts gstreamer mysql"
# kde: enables compilation of the konqueror sidebar plugin

KEYWORDS="~amd64 ~ppc -sparc ~x86"

#	Not yet released:
#	">=media-libs/libvisual-0.2.0
RDEPEND="kde? ( || ( kde-base/konqueror kde-base/kdebase ) )
	 arts? ( || ( kde-base/kdemultimedia-arts kde-base/kdemultimedia )
		 || ( kde-base/akode kde-base/kdemultimedia )
		 kde-base/arts )
	 opengl? ( virtual/opengl )
	 xmms? ( >=media-sound/xmms-1.2 )
	 xine? ( >=media-libs/xine-lib-1_rc4 )
	 >=media-libs/tunepimp-0.3.0
	 >=media-libs/taglib-1.3.1
	 gstreamer? ( >=media-libs/gst-plugins-0.8.6
	 	      >=media-plugins/gst-plugins-mad-0.8.6 )
	 mysql? ( >=dev-db/mysql-3 )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9.0"

need-kde 3.2

src_unpack() {
	if use !xine && use !arts && use !gstreamer
	then
		die "You must enable either aRts or Xine or GStreamer"
	fi

	kde_src_unpack
	#CJK mp3 tag fix
	use cjk && epatch ${FILESDIR}/amarok-1.0-cjk-a.diff
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
