# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/kmuddy/kmuddy-1.0.1-r1.ebuild,v 1.1 2012/01/01 12:22:57 dilfridge Exp $

EAPI=3

KDE_LINGUAS="es"
KDE_DOC_DIRS="doc/${PN}"
KDE_HANDBOOK=optional
inherit kde4-base

DESCRIPTION="MUD client for KDE"
HOMEPAGE="http://www.kmuddy.com/"
SRC_URI="http://www.kmuddy.com/releases/stable/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug"

DOC="AUTHORS README CHANGELOG Scripting-HOWTO TODO DESIGN"

PATCHES=(
	"${FILESDIR}"/${P}-{gcc,kde}45.patch
	"${FILESDIR}"/${P}-underlinking.patch
	"${FILESDIR}"/${P}-tempnam.patch
)

src_configure() {
	# not in portage yet
	mycmakeargs+=(
		-DWITH_MXP=OFF
	)
	kde4-base_src_configure
}
