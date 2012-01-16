# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim-icons/kdepim-icons-4.7.4.ebuild,v 1.3 2012/01/16 22:19:09 ago Exp $

EAPI=4

KMNAME="kdepim"
KMMODULE="icons"
KDE_SCM="git"
inherit kde4-meta

DESCRIPTION="KDE PIM icons"
IUSE=""
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"

DEPEND="$(add_kdebase_dep kdepimlibs)"
RDEPEND=""
