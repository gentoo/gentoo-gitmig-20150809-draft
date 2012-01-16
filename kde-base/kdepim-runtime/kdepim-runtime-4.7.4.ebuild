# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim-runtime/kdepim-runtime-4.7.4.ebuild,v 1.3 2012/01/16 22:22:37 ago Exp $

EAPI=4

KMNAME="kdepim-runtime"
KDE_SCM="git"
inherit kde4-base

DESCRIPTION="KDE PIM runtime plugin collection"
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RESTRICT="test"
# Would need test programs _testrunner and akonaditest from kdepimlibs, see bug 313233

DEPEND="
	app-misc/strigi
	>=app-office/akonadi-server-1.3.60
	dev-libs/boost
	dev-libs/libxml2:2
	dev-libs/libxslt
	>=dev-libs/shared-desktop-ontologies-0.6.51
	$(add_kdebase_dep kdepimlibs 'semantic-desktop')
	x11-misc/shared-mime-info
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kdepim-icons)
"
