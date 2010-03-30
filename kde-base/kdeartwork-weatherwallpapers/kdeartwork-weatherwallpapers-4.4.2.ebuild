# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-weatherwallpapers/kdeartwork-weatherwallpapers-4.4.2.ebuild,v 1.1 2010/03/30 19:47:10 spatz Exp $

EAPI="3"

KMNAME="kdeartwork"
KMMODULE="WeatherWallpapers"
inherit kde4-meta

DESCRIPTION="Weather aware wallpapers. Changes with weather outside."
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	$(add_kdebase_dep kdeartwork-wallpapers)
"
