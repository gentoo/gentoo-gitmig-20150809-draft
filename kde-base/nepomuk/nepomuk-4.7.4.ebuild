# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/nepomuk/nepomuk-4.7.4.ebuild,v 1.1 2011/12/11 18:52:20 alexxy Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kde-runtime"
inherit kde4-meta

DESCRIPTION="Nepomuk KDE4 client"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	>=app-misc/strigi-0.6.3[dbus,qt4]
	>=dev-libs/soprano-2.6.51[dbus,raptor,redland,virtuoso]
	$(add_kdebase_dep kdelibs 'semantic-desktop')
	!kde-misc/nepomukcontroller
"
RDEPEND="${DEPEND}"

RESTRICT="test"
# bug 392989
