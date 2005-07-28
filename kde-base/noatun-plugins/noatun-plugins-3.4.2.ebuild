# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/noatun-plugins/noatun-plugins-3.4.2.ebuild,v 1.1 2005/07/28 21:16:26 danarmak Exp $
KMNAME=kdeaddons
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Various plugins for noatun"
KEYWORDS=" ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="arts sdl berkdb"
DEPEND="$(deprange-dual $PV $MAXKDEVER kde-base/noatun)
	arts? ( $(deprange $PV $MAXKDEVER kde-base/arts) )
	sdl? ( >=media-libs/libsdl-1.2 )
	berkdb? ( =sys-libs/db-4.2* )"

PATCHES="$FILESDIR/configure-fix-kdeaddons-db.patch
	$FILESDIR/configure-fix-kdeaddons-sdl.patch"
myconf="$(use_with berkdb berkeley-db) $(use_with sdl) --with-db-lib=db_cxx-4.2"

