# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaddons/kdeaddons-3.4.0.ebuild,v 1.3 2005/03/18 17:57:09 morfic Exp $

inherit kde-dist eutils

DESCRIPTION="KDE addon modules: plugins for konqueror, noatun etc"

KEYWORDS="~x86 ~amd64 ~sparc ~ppc"
IUSE="arts sdl xmms berkdb"

DEPEND="~kde-base/kdepim-${PV}
	~kde-base/kdemultimedia-${PV}
	~kde-base/kdegames-${PV}
	arts? ( ~kde-base/arts-${PV} )
	sdl? ( >=media-libs/libsdl-1.2 )
	xmms? ( media-sound/xmms )
	berkdb? ( =sys-libs/db-4.2* )"

src_unpack() {
	kde_src_unpack

	# Make vimpart use /usr/bin/kvim -- fixes bug 33257.
	# This should continue to apply to upcoming versions since it's
	# Gentoo-specific and won't go upstream.
	epatch "${FILESDIR}/${PN}-3.2.0-kvim.diff"

	# This patch makes the configure test in noatun-oblique find db_cxx.h,
	# but it also makes db support non-optional. should be fixed, ideally
	if useq berkdb; then
		epatch "${FILESDIR}/noatun-oblique-db-location-3.4.0.diff"
		myconf="--with-extra-includes=/usr/include/db4.2"

		rm ${S}/configure
	fi
}

src_compile() {
	use sdl && myconf="$myconf --with-sdl --with-sdl-prefix=/usr" || myconf="$myconf --without-sdl --disable-sdltest"
	use xmms || export ac_cv_have_xmms=no

	kde_src_compile
}
