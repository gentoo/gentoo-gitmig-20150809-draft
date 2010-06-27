# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-wallpapers/kdeartwork-wallpapers-4.4.4-r1.ebuild,v 1.4 2010/06/27 11:12:12 fauli Exp $

EAPI="3"

RESTRICT="binchecks strip"

KMMODULE="wallpapers"
KMNAME="kdeartwork"
inherit kde4-meta

DESCRIPTION="Wallpapers from kde"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~ppc64 ~sparc x86 ~amd64-linux ~x86-linux"
IUSE=""

# Please bump this as needed (probably at least for every minor version)
add_blocker kdebase-wallpapers '<4.4.0'

KMEXTRA="
	HighResolutionWallpapers/
"
