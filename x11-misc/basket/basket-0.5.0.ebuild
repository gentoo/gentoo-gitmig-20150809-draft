# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/basket/basket-0.5.0.ebuild,v 1.4 2006/03/11 23:01:34 hansmi Exp $

inherit eutils kde

DESCRIPTION="A DropDrawers clone. Multiple information organizer"
HOMEPAGE="http://basket.kde.org/"
SRC_URI="http://basket.kde.org/downloads/index.php?file=${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

need-kde 3.3

src_unpack() {
	kde_src_unpack

	# patch from basket developer to solve compilation
	# problemes on systems without arts
	use arts || epatch ${FILESDIR}/${P}-noarts.patch
}

