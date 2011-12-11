# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/smokegen/smokegen-4.7.4.ebuild,v 1.1 2011/12/11 18:52:13 alexxy Exp $

EAPI=4

KDE_REQUIRED="never"
KDE_SCM="git"
inherit kde4-base

DESCRIPTION="Scripting Meta Object Kompiler Engine - generators"
KEYWORDS="~amd64 ~x86"
IUSE="aqua debug"

DEPEND="
	x11-libs/qt-core:4[aqua=]
"
RDEPEND="${DEPEND}"

add_blocker smoke
