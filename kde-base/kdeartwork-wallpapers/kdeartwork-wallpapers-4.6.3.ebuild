# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-wallpapers/kdeartwork-wallpapers-4.6.3.ebuild,v 1.1 2011/05/07 10:47:29 scarabeus Exp $

EAPI=4

RESTRICT="binchecks strip"

KMMODULE="wallpapers"
KMNAME="kdeartwork"
inherit kde4-meta

DESCRIPTION="Wallpapers from kde"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

# Please bump this as needed (probably at least for every minor version)
add_blocker kdebase-wallpapers '<4.6.0'
add_blocker kdeartwork-weatherwallpapers '<4.6.0'

KMEXTRA="
	HighResolutionWallpapers/
"
