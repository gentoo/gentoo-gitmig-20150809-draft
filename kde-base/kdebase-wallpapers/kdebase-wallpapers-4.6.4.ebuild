# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-wallpapers/kdebase-wallpapers-4.6.4.ebuild,v 1.1 2011/06/10 18:00:06 dilfridge Exp $

EAPI=4

KMNAME="kdebase-workspace"
KMMODULE="wallpapers"
KDE_SCM="svn"
KDE_REQUIRED="never"
inherit kde4-meta

DESCRIPTION="KDE wallpapers"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

src_configure() {
	mycmakeargs=( -DWALLPAPER_INSTALL_DIR="${EPREFIX}/usr/share/wallpapers" )

	kde4-base_src_configure
}
