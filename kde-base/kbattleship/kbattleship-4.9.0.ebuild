# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kbattleship/kbattleship-4.9.0.ebuild,v 1.1 2012/08/01 22:17:03 johu Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdegames"
KDE_SELINUX_MODULE="games"
inherit games-ggz kde4-meta

DESCRIPTION="The KDE Battleship clone"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

src_prepare() {
	# cmake is doing this really weird
	sed -i \
		-e "s:register_ggz_module:#register_ggz_module:g" \
		"${PN}"/src/CMakeLists.txt || die "ggz removal failed"

	kde4-meta_src_prepare
}
