# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/crystal/crystal-2.0.5.ebuild,v 1.6 2011/02/02 05:48:35 tampakrap Exp $

EAPI=3
inherit kde4-base

DESCRIPTION="Crystal decoration theme for KDE4.x"
HOMEPAGE="http://kde-look.org/content/show.php/Crystal?content=75140"
SRC_URI="http://kde-look.org/CONTENT/content-files/75140-${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="amd64 x86"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kwin)
"

MAKEOPTS="${MAKEOPTS} -j1"

DOCS=( AUTHORS README )
