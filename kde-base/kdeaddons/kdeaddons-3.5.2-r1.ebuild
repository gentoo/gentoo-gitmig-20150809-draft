# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaddons/kdeaddons-3.5.2-r1.ebuild,v 1.9 2006/06/03 10:50:22 gmsoft Exp $

inherit kde-dist

DESCRIPTION="KDE addon modules: plugins for konqueror, noatun etc."

KEYWORDS="alpha amd64 hppa ~ia64 ~mips ppc ppc64 sparc x86"
IUSE="arts berkdb sdl xmms"

DEPEND="~kde-base/kdepim-${PV}
	~kde-base/kdemultimedia-${PV}
	~kde-base/kdegames-${PV}
	arts? ( ~kde-base/arts-${PV} )
	sdl? ( >=media-libs/libsdl-1.2 )
	xmms? ( media-sound/xmms )
	berkdb? ( || ( =sys-libs/db-4.3*
	               =sys-libs/db-4.2* ) )
	!kde-misc/metabar"

PATCHES="${FILESDIR}/konq-plugins-3.5.2-arkplugin-crash-fix.diff"

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
