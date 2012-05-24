# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcontrol/kcontrol-4.8.3.ebuild,v 1.4 2012/05/24 08:25:18 ago Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kde-runtime"
inherit kde4-meta

DESCRIPTION="The KDE Control Center"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep kdnssd)
	$(add_kdebase_dep khotkeys)
"
