# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/blogilo/blogilo-4.4.11.1.ebuild,v 1.1 2011/04/21 21:09:55 dilfridge Exp $

EAPI=4

KDE_MINIMAL="4.6"
KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="KDE Blogging Client"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook"

DEPEND="
	$(add_kdebase_dep kdepimlibs)
"
RDEPEND="${DEPEND}
	!kde-misc/bilbo
	!kde-misc/blogilo
"

PATCHES=( "${FILESDIR}/${PN}"-4.4.10-nosoprano.patch )
