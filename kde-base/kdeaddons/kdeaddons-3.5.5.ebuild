# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaddons/kdeaddons-3.5.5.ebuild,v 1.8 2006/12/03 19:39:27 corsair Exp $

inherit db-use kde-dist

DESCRIPTION="KDE addon modules: Plugins for Konqueror, Noatun,..."

KEYWORDS="~alpha amd64 hppa ~ia64 ~mips ppc ppc64 sparc x86"
IUSE="arts berkdb sdl"

DEPEND="~kde-base/kdepim-${PV}
	~kde-base/kdemultimedia-${PV}
	~kde-base/kdegames-${PV}
	arts? ( ~kde-base/arts-${PV} )
	sdl? ( >=media-libs/libsdl-1.2 )
	berkdb? ( =sys-libs/db-4* )
	!kde-misc/metabar"
RDEPEND="${DEPEND}"

src_compile() {
	local myconf="$(use_with sdl) --without-xmms"

	if use berkdb; then
		dblib="$(db_libname)"
		myconf="${myconf} --with-berkeley-db --with-db-lib=${dblib/-/_cxx-}
			--with-extra-includes=${ROOT}$(db_includedir)"
	else
		myconf="${myconf} --without-berkeley-db"
	fi

	kde_src_compile
}
