# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kjots/kjots-4.4.8.ebuild,v 1.1 2010/12/06 10:28:21 tampakrap Exp $

EAPI="3"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="KDE note taking utility"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook"

DEPEND="
	$(add_kdebase_dep kdepimlibs)
"
RDEPEND="${DEPEND}"
