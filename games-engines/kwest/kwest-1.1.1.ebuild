# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/kwest/kwest-1.1.1.ebuild,v 1.3 2009/01/20 15:41:05 tupone Exp $

ARTS_REQUIRED=yes #bug #207816
inherit kde
need-kde 3

DESCRIPTION="An Inform interactive fiction interpreter for KDE"
HOMEPAGE="http://kwest.sourceforge.net/"
SRC_URI="mirror://sourceforge/kwest/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

S=${WORKDIR}/${PN}

PATCHES=( "${FILESDIR}"/${P}-gcc43.patch )
