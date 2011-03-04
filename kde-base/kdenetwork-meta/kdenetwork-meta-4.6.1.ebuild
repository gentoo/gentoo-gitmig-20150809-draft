# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdenetwork-meta/kdenetwork-meta-4.6.1.ebuild,v 1.1 2011/03/04 17:59:56 alexxy Exp $

EAPI=3
inherit kde4-functions

DESCRIPTION="kdenetwork - merge this to pull in all kdenetwork-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="4.6"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="aqua kdeprefix ppp"

RDEPEND="
	$(add_kdebase_dep kdenetwork-filesharing)
	$(add_kdebase_dep kdnssd)
	$(add_kdebase_dep kget)
	$(add_kdebase_dep kopete)
	$(add_kdebase_dep krdc)
	$(add_kdebase_dep krfb)
	ppp? ( $(add_kdebase_dep kppp) )
	$(block_other_slots)
"
