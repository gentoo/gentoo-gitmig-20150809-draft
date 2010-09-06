# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-wallpapers/kdeartwork-wallpapers-4.5.1.ebuild,v 1.1 2010/09/05 23:51:24 tampakrap Exp $

EAPI="3"

RESTRICT="binchecks strip"

KMMODULE="wallpapers"
KMNAME="kdeartwork"
inherit kde4-meta

DESCRIPTION="Wallpapers from kde"
KEYWORDS=""
IUSE=""

# Please bump this as needed (probably at least for every minor version)
add_blocker kdebase-wallpapers '<4.4.90'
add_blocker kdeartwork-weatherwallpapers '<4.5.0'

KMEXTRA="
	HighResolutionWallpapers/
"
