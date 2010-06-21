# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmenuedit/kmenuedit-4.3.5.ebuild,v 1.4 2010/06/21 15:53:52 scarabeus Exp $

EAPI="2"

KMNAME="kdebase-workspace"
inherit kde4-meta

DESCRIPTION="KDE menu editor"
KEYWORDS="~alpha amd64 ~arm ~ia64 ppc ~ppc64 ~sparc x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook"

RDEPEND="
	$(add_kdebase_dep khotkeys)
"

KMEXTRACTONLY="
	libs/kworkspace/
"

src_configure() {
	sed -i -e \
		"s:\${CMAKE_CURRENT_BINARY_DIR}/../khotkeys/app/org.kde.khotkeys.xml:${EKDEDIR}/share/dbus-1/interfaces/org.kde.khotkeys.xml:g" \
		kmenuedit/CMakeLists.txt \
		|| die "sed failed"

	kde4-meta_src_configure
}
