# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/noatun-nexscope/noatun-nexscope-3.4.0_beta1.ebuild,v 1.1 2005/01/15 02:24:41 danarmak Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="noatun-plugins/configure.in.in noatun-plugins/nexscope"
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="noatun visualizatin plugin"
KEYWORDS="~x86"
IUSE=""
DEPEND="$(deprange-dual $PV $MAXKDEVER kde-base/noatun)
		>=media-libs/libsdl-1.2"
OLDDEPEND=">=media-libs/libsdl-1.2 ~kde-base/noatun-$PV"

myconf="--with-sdl-prefix=/usr"
