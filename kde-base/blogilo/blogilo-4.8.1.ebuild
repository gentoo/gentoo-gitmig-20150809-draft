# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/blogilo/blogilo-4.8.1.ebuild,v 1.1 2012/03/06 23:35:36 dilfridge Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdepim"
KDE_SCM="git"
inherit kde4-meta

DESCRIPTION="KDE Blogging Client"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdepimlibs)
"
RDEPEND="${DEPEND}
"
