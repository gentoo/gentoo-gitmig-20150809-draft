# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/smokegen/smokegen-4.8.3.ebuild,v 1.4 2012/05/24 10:15:51 ago Exp $

EAPI=4

KDE_REQUIRED="never"
KDE_SCM="git"
inherit kde4-base

DESCRIPTION="Scripting Meta Object Kompiler Engine - generators"
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="aqua debug"

DEPEND="
	x11-libs/qt-core:4[aqua=]
"
RDEPEND="${DEPEND}"

add_blocker smoke
