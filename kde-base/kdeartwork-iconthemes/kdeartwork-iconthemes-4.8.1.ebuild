# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-iconthemes/kdeartwork-iconthemes-4.8.1.ebuild,v 1.1 2012/03/06 23:35:15 dilfridge Exp $

EAPI=4

KMNAME="kdeartwork"
KMMODULE="IconThemes"
inherit kde4-meta

DESCRIPTION="Icon themes for kde"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

# Provides nuvola icon theme
RDEPEND="
	!x11-themes/nuvola
"

# Moved here in 4.7
add_blocker kdeaccessibility-iconthemes
