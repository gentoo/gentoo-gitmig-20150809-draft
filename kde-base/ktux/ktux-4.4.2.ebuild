# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ktux/ktux-4.4.2.ebuild,v 1.1 2010/03/30 21:44:30 spatz Exp $

EAPI="3"

KMNAME="kdetoys"
inherit kde4-meta

DESCRIPTION="KDE: screensaver featuring the Space-Faring Tux"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

# libkworkspace - only as a stub to provide KDE4Workspace config
DEPEND="
	$(add_kdebase_dep kscreensaver)
	$(add_kdebase_dep libkworkspace)
"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e's/${KDE4WORKSPACE_KSCREENSAVER_LIBRARY}/kscreensaver/' \
		"${PN}"/CMakeLists.txt || die "Failed to patch CMakeLists.txt"

	kde4-meta_src_prepare
}
