# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/amarok/amarok-1.0.2.ebuild,v 1.2 2004/09/03 09:19:57 eradicator Exp $

inherit kde eutils

DESCRIPTION="amaroK is a media player for KDE"
HOMEPAGE="http://amarok.sourceforge.net/"
SRC_URI="mirror://sourceforge/amarok/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc amd64"
IUSE="cjk gstreamer xmms arts opengl xine"

DEPEND=">=kde-base/kdemultimedia-3.2
	arts? ( >=kde-base/arts-1.2 )
	gstreamer? ( >=media-libs/gst-plugins-0.8.1 )
	opengl? ( virtual/opengl )
	xmms? ( >=media-sound/xmms-1.2 )
	xine? ( >=media-libs/xine-lib-1_rc4 )
	>=dev-util/pkgconfig-0.9.0
	>=media-libs/taglib-0.95"
need-kde 3.2

src_unpack() {
	if  ! use arts && ! use gstreamer && ! use xine
	then
		die "You must enable either Arts, Gstreamer, or Xine"
	fi

	kde_src_unpack
	#CJK mp3 tag fix
	use cjk && epatch ${FILESDIR}/amarok-1.0-cjk-a.diff
}

src_compile() {
	PREFIX="`kde-config --prefix`"
	myconf="`use_with arts` `use_with gstreamer` `use_with opengl` `use_with xine`"

	kde_src_compile myconf configure make || die
}

