# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-weatherwallpapers/kdeartwork-weatherwallpapers-4.6.3.ebuild,v 1.2 2011/06/08 23:12:55 tomka Exp $

EAPI=4

KMNAME="kdeartwork"
KMMODULE="WeatherWallpapers"
inherit kde4-meta

DESCRIPTION="Weather aware wallpapers. Changes with weather outside."
KEYWORDS="~amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	$(add_kdebase_dep kdeartwork-wallpapers)
"
