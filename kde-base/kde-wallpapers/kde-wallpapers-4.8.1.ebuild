# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-wallpapers/kde-wallpapers-4.8.1.ebuild,v 1.4 2012/04/18 19:06:17 maekke Exp $

EAPI=4

KMNAME="kde-wallpapers"
KDE_SCM="svn"
inherit kde4-base

DESCRIPTION="KDE wallpapers"
KEYWORDS="amd64 ~arm x86 ~amd64-linux ~x86-linux"
IUSE=""

add_blocker kdebase-wallpapers

src_configure() {
	mycmakeargs=( -DWALLPAPER_INSTALL_DIR="${EPREFIX}/usr/share/wallpapers" )

	kde4-base_src_configure
}
