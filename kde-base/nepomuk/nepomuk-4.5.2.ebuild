# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/nepomuk/nepomuk-4.5.2.ebuild,v 1.1 2010/10/06 09:17:23 alexxy Exp $

EAPI="3"

KDE_HANDBOOK="optional"
KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="Nepomuk KDE4 client"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	>=app-misc/strigi-0.6.3[dbus,qt4]
	>=dev-libs/soprano-2.4.64[dbus,raptor,redland,virtuoso]
	$(add_kdebase_dep kdelibs 'semantic-desktop')
"
RDEPEND="${DEPEND}"

# BLOCKS:
# kde-base/akonadi: installed nepomuk ontologies, which were supposed to be here
add_blocker akonadi '<4.2.60'
