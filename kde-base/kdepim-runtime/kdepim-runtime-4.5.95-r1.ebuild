# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim-runtime/kdepim-runtime-4.5.95-r1.ebuild,v 1.1 2011/05/09 20:44:35 scarabeus Exp $

EAPI=4

KMNAME="kdepim-runtime"
KDE_SCM="git"
inherit kde4-base

DESCRIPTION="KDE PIM runtime plugin collection"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RESTRICT="test"
# Would need test programs _testrunner and akonaditest from kdepimlibs, see bug 313233

DEPEND="
	app-misc/strigi
	>=app-office/akonadi-server-1.3.60
	dev-libs/boost
	dev-libs/libxml2:2
	dev-libs/libxslt
	$(add_kdebase_dep kdepimlibs 'semantic-desktop')
	x11-misc/shared-mime-info
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kdepim-icons)
"

add_blocker kdemaildir '<4.3.0'
add_blocker akonadi '<4.3.90'

src_prepare() {
	sed -i \
		-e '/add_subdirectory(po)/ s/^/ #DONOTWANT/' \
		CMakeLists.txt || die
	kde4-base_src_prepare
}
