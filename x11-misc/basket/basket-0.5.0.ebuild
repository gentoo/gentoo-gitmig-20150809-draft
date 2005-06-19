# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/basket/basket-0.5.0.ebuild,v 1.1 2005/06/19 16:04:26 smithj Exp $

inherit eutils kde

need-kde 3.3
need-qt 3

IUSE="arts"
DESCRIPTION="A DropDrawers clone. Multiple information organizer"
HOMEPAGE="http://basket.kde.org/"
SRC_URI="http://basket.kde.org/downloads/index.php?file=${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

DEPEND="virtual/x11
	arts? ( kde-base/arts )"

DOCS="AUTHORS ChangeLog INSTALL NEWS REDME TODO"

src_unpack() {
	unpack ${A}

	cd ${S}
	# patch from basket developer to solve compilation
	# problemes on systems without arts
	! use arts && epatch ${FILESDIR}/${P}-noarts.patch
}

