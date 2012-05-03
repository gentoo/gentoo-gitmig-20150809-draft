# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-weatherwallpapers/kdeartwork-weatherwallpapers-4.8.3.ebuild,v 1.1 2012/05/03 20:08:07 johu Exp $

EAPI=4

KMNAME="kdeartwork"
KMMODULE="WeatherWallpapers"
inherit kde4-meta

DESCRIPTION="Weather aware wallpapers. Changes with weather outside."
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	$(add_kdebase_dep kdeartwork-wallpapers)
"
