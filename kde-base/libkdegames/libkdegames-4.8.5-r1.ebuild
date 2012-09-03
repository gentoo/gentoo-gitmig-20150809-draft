# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdegames/libkdegames-4.8.5-r1.ebuild,v 1.1 2012/09/03 17:12:04 johu Exp $

EAPI=4

KMNAME="kdegames"
inherit kde4-meta

DESCRIPTION="Base library common to many KDE games."
KEYWORDS="amd64 ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	>=dev-games/ggz-client-libs-0.0.14
"
RDEPEND="${DEPEND}"

KMSAVELIBS="true"

KMEXTRA+="
	cmake/modules/"

PATCHES=(
	"${FILESDIR}"/${PN}-4.2.0-darwin.patch
)
