# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdetoys-meta/kdetoys-meta-4.8.3.ebuild,v 1.3 2012/05/18 19:48:44 ago Exp $

EAPI=4
inherit kde4-meta-pkg

DESCRIPTION="KDE toys - merge this to pull in all kdetoys-derived packages"
KEYWORDS="amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	$(add_kdebase_dep amor)
	$(add_kdebase_dep kteatime)
	$(add_kdebase_dep ktux)
"
