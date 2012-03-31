# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim-icons/kdepim-icons-4.8.1.ebuild,v 1.2 2012/03/31 14:56:43 maekke Exp $

EAPI=4

KMNAME="kdepim"
KMMODULE="icons"
KDE_SCM="git"
inherit kde4-meta

DESCRIPTION="KDE PIM icons"
IUSE=""
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-linux"

DEPEND="$(add_kdebase_dep kdepimlibs)"
RDEPEND=""
