# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/kmuddy/kmuddy-1.0.1.ebuild,v 1.6 2011/01/31 02:05:42 tampakrap Exp $

EAPI=3

KDE_LINGUAS="es"
KDE_DOC_DIRS="doc/${PN}"
inherit kde4-base

DESCRIPTION="MUD client for KDE"
HOMEPAGE="http://www.kmuddy.com/"
SRC_URI="http://www.kmuddy.com/releases/stable/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="amd64 ~ppc x86"
IUSE="debug handbook"

DOC="AUTHORS README CHANGELOG Scripting-HOWTO TODO DESIGN"

PATCHES=( "${FILESDIR}"/${P}-{gcc,kde}45.patch )

src_configure() {
	# not in portage yet
	mycmakeargs+=(
		-DWITH_MXP=OFF
	)
	kde4-base_src_configure
}
