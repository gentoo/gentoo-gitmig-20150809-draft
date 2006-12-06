# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/noatun-plugins/noatun-plugins-3.5.5.ebuild,v 1.7 2006/12/06 12:55:44 kloeri Exp $
KMNAME=kdeaddons
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit db-use kde-meta

DESCRIPTION="Various plugins for Noatun."
KEYWORDS="alpha amd64 ~ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="arts sdl berkdb"

DEPEND="$(deprange-dual $PV $MAXKDEVER kde-base/noatun)
	arts? ( $(deprange $PV $MAXKDEVER kde-base/arts) )
	sdl? ( >=media-libs/libsdl-1.2 )
	berkdb? ( =sys-libs/db-4* )"

RDEPEND="${DEPEND}"

src_compile() {
	local myconf="$(use_with sdl)"

	if use berkdb; then
		dblib="$(db_libname)"
		myconf="${myconf} --with-berkeley-db --with-db-lib=${dblib/-/_cxx-}
			--with-extra-includes=${ROOT}$(db_includedir)"
	else
		myconf="${myconf} --without-berkeley-db"
	fi

	kde-meta_src_compile
}
