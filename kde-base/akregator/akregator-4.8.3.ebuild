# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/akregator/akregator-4.8.3.ebuild,v 1.1 2012/05/03 20:08:00 johu Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdepim"
KDE_SCM="git"
inherit kde4-meta

DESCRIPTION="KDE news feed aggregator."
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdepimlibs)
	$(add_kdebase_dep kdepim-common-libs)
"
RDEPEND="${DEPEND}"

KMLOADLIBS="kdepim-common-libs"
