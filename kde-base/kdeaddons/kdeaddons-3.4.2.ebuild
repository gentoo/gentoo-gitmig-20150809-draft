# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaddons/kdeaddons-3.4.2.ebuild,v 1.1 2005/07/28 12:54:24 greg_g Exp $

inherit kde-dist eutils

DESCRIPTION="KDE addon modules: plugins for konqueror, noatun etc"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE="arts berkdb sdl xmms"

DEPEND="~kde-base/kdepim-${PV}
	~kde-base/kdemultimedia-${PV}
	~kde-base/kdegames-${PV}
	arts? ( ~kde-base/arts-${PV} )
	sdl? ( >=media-libs/libsdl-1.2 )
	xmms? ( media-sound/xmms )
	berkdb? ( || ( =sys-libs/db-4.3*
	               =sys-libs/db-4.2* ) )"

src_unpack() {
	kde_src_unpack

	# Make vimpart use /usr/bin/kvim -- fixes bug 33257.
	# This should continue to apply to upcoming versions since it's
	# Gentoo-specific and won't go upstream.
	epatch "${FILESDIR}/${PN}-3.2.0-kvim.diff"

	# Configure patch. Applied for 3.5.
	epatch "${FILESDIR}/kdeaddons-3.4-configure.patch"

	# For the configure patch.
	make -f admin/Makefile.common || die
}

src_compile() {
	local myconf="$(use_with sdl) $(use_with xmms)"

	if use berkdb; then
		if has_version "=sys-libs/db-4.3*"; then
			myconf="${myconf} --with-berkeley-db --with-db-lib=db_cxx-4.3
			        --with-extra-includes=/usr/include/db4.3"
		elif has_version "=sys-libs/db-4.2*"; then
			myconf="${myconf} --with-berkeley-db --with-db-lib=db_cxx-4.2
			        --with-extra-includes=/usr/include/db4.2"
		fi
	else
		myconf="${myconf} --without-berkeley-db"
	fi

	kde_src_compile
}
