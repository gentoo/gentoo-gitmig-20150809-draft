# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/amarok/amarok-1.0_beta1.ebuild,v 1.4 2004/04/24 15:04:19 lanius Exp $

inherit kde

MY_P="${P/_beta/-beta}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="amaroK is a media player for KDE"
HOMEPAGE="http://amarok.sourceforge.net/"
SRC_URI="mirror://sourceforge/amarok/${MY_P}.tar.bz2"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="gstreamer xmms arts opengl"

DEPEND=">=kde-base/kdemultimedia-3.2
	gstreamer? ( >=media-libs/gst-plugins-0.8.0 )
	opengl? ( virtual/opengl )
	xmms? ( >=media-sound/xmms-1.2 )
	>=dev-util/pkgconfig-0.9.0
	>=media-libs/taglib-0.95"

need-kde 3.2

src_unpack() {
	if  ! use arts && ! use gstreamer
	then
		die "You must enable either Arts or Gstreamer"
	fi

	kde_src_unpack
}

src_compile() {
	PREFIX="`kde-config --prefix`"
	myconf="`use_with arts` `use_with gstreamer` `use_with opengl`"

	kde_src_compile myconf configure make || die
}
