# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/crystal/crystal-2.0.5.ebuild,v 1.1 2009/08/23 13:31:50 ssuominen Exp $

EAPI=2

inherit kde4-base

DESCRIPTION="Crystal decoration theme for KDE4.x"
HOMEPAGE="http://kde-look.org/content/show.php/Crystal?content=75140"
SRC_URI="http://kde-look.org/CONTENT/content-files/75140-${P}.tar.bz2"

IUSE="debug"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"

MAKEOPTS="${MAKEOPTS} -j1"

src_install() {
	kde4-base_src_install
	mv "${D}"/usr/share/apps/kwin/crystal.desktop \
		"${D}"/usr/share/apps/kwin/crystal-${SLOT}.desktop \
		|| die "moving desktop file failed"
}
