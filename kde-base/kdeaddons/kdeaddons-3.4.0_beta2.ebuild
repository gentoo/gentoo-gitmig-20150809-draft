# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaddons/kdeaddons-3.4.0_beta2.ebuild,v 1.1 2005/02/09 16:15:27 greg_g Exp $

inherit kde-dist eutils

DESCRIPTION="KDE addon modules: plugins for konqueror, noatun etc"

KEYWORDS="~x86 ~amd64"
IUSE="arts sdl xmms"

DEPEND="~kde-base/kdepim-${PV}
	~kde-base/kdemultimedia-${PV}
	~kde-base/kdegames-${PV}
	arts? ( ~kde-base/arts-${PV} )
	sdl? ( >=media-libs/libsdl-1.2 )
	xmms? ( media-sound/xmms )"

src_unpack() {
	kde_src_unpack

	# Make vimpart use /usr/bin/kvim -- fixes bug 33257.
	# This should continue to apply to upcoming versions since it's
	# Gentoo-specific and won't go upstream.
	epatch ${FILESDIR}/${PN}-3.2.0-kvim.diff
}

src_compile() {
	use sdl && myconf="$myconf --with-sdl --with-sdl-prefix=/usr" || myconf="$myconf --without-sdl --disable-sdltest"
	use xmms || export ac_cv_have_xmms=no

	kde_src_compile
}
