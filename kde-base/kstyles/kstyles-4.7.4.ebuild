# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kstyles/kstyles-4.7.4.ebuild,v 1.5 2012/02/18 16:00:43 nixnut Exp $

EAPI=4

KMNAME="kde-workspace"
inherit kde4-meta

DESCRIPTION="KDE: A set of different KDE styles."
KEYWORDS="amd64 ~arm ppc ~ppc64 x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep liboxygenstyle)
	<x11-libs/qt-core-4.8.0
	<x11-libs/qt-gui-4.8.0
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	libs/oxygen
"
