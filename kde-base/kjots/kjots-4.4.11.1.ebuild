# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kjots/kjots-4.4.11.1.ebuild,v 1.1 2011/04/21 21:37:43 dilfridge Exp $

EAPI=4

KDE_MINIMAL="4.6"
KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="KDE note taking utility"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook"

DEPEND="
	$(add_kdebase_dep kdepimlibs)
	$(add_kdebase_dep libkdepim)
"
RDEPEND="${DEPEND}"
