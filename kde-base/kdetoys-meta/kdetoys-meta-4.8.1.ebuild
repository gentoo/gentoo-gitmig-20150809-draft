# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdetoys-meta/kdetoys-meta-4.8.1.ebuild,v 1.1 2012/03/06 23:35:30 dilfridge Exp $

EAPI=4
inherit kde4-meta-pkg

DESCRIPTION="KDE toys - merge this to pull in all kdetoys-derived packages"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	$(add_kdebase_dep amor)
	$(add_kdebase_dep kteatime)
	$(add_kdebase_dep ktux)
"
