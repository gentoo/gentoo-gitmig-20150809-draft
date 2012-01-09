# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/smokegen/smokegen-4.7.4-r1.ebuild,v 1.2 2012/01/09 17:50:24 phajdan.jr Exp $

EAPI=4

KDE_REQUIRED="never"
KDE_SCM="git"
inherit kde4-base

DESCRIPTION="Scripting Meta Object Kompiler Engine - generators"
KEYWORDS="~amd64 x86"
IUSE="aqua debug"

DEPEND="
	x11-libs/qt-core:4[aqua=]
"
RDEPEND="${DEPEND}"

add_blocker smoke

PATCHES=( "${FILESDIR}/${P}-akonadicrash.patch" )
