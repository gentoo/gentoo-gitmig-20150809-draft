# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim-runtime/kdepim-runtime-4.4.4.ebuild,v 1.2 2010/06/24 08:00:41 angelos Exp $

EAPI="3"

if [[ ${PV} = *9999* ]]; then
	KMNAME="kdepim"
	KMMODULE="runtime"
	inherit kde4-meta
else
	inherit kde4-base
fi

DESCRIPTION="KDE PIM runtime plugin collection"
KEYWORDS="amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	app-misc/strigi
	>=app-office/akonadi-server-1.3.1
	dev-libs/boost
	dev-libs/libxml2:2
	dev-libs/libxslt
	$(add_kdebase_dep kdelibs 'semantic-desktop')
	$(add_kdebase_dep kdepimlibs 'semantic-desktop')
	$(add_kdebase_dep libkdepim)
	x11-misc/shared-mime-info
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kdepim-icons)
"

add_blocker akonadi '<4.3.90'
