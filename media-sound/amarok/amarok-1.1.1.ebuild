# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/amarok/amarok-1.1.1.ebuild,v 1.12 2004/12/04 21:39:01 eradicator Exp $

IUSE="noamazon cjk xmms opengl xine arts gstreamer"

inherit kde eutils

MY_P="${P/_beta/-beta}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="amaroK is a media player for KDE"
HOMEPAGE="http://amarok.kde.org/"
SRC_URI="mirror://sourceforge/amarok/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~ppc -sparc ~x86"

DEPEND="=media-libs/libvisual-0.1.6
	>=kde-base/kdemultimedia-3.2
	arts? ( >=kde-base/arts-1.2 )
	opengl? ( virtual/opengl )
	xmms? ( >=media-sound/xmms-1.2 )
	xine? ( >=media-libs/xine-lib-1_rc4 )
	>=media-libs/tunepimp-0.3.0
	>=dev-util/pkgconfig-0.9.0
	>=media-libs/taglib-1.3
	>=kde-base/kdelibs-3.2
	>=x11-libs/qt-3.3
	gstreamer? ( >=media-libs/gst-plugins-0.8.1
	             >=media-plugins/gst-plugins-mad-0.8.1 )"

need-kde 3.2

src_unpack() {
	if  use !xine && use !arts
	then
		die "You must enable either aRts or Xine"
	fi

	kde_src_unpack
	#CJK mp3 tag fix
	use cjk && epatch ${FILESDIR}/amarok-1.0-cjk-a.diff
}

src_compile() {
	PREFIX="`kde-config --prefix`"

	myconf="`use_with arts` `use_with xine` `use_with gstreamer`"
	myconf="${myconf} `use_with opengl` `use_enable !noamazon amazon`"

	kde_src_compile myconf configure make || die
}

pkg_postinst() {
	if use gstreamer; then
		ewarn "Gstreamer support in ${P} is known to be unstable (see bug #66902)"
	fi
}
