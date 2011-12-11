# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-colorschemes/kdeartwork-colorschemes-4.7.4.ebuild,v 1.1 2011/12/11 18:52:38 alexxy Exp $

EAPI=4

KMNAME="kdeartwork"
KMMODULE="ColorSchemes"
inherit kde4-meta

DESCRIPTION="KDE extra colorschemes"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

# Moved here in 4.7
add_blocker kdeaccessibility-colorschemes
