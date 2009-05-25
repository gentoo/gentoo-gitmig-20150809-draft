# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libkdcraw/libkdcraw-0.1.9.ebuild,v 1.1 2009/05/25 14:47:24 scarabeus Exp $

EAPI=1

ARTS_REQUIRED="never"

inherit kde

DESCRIPTION="KDE Image Plugin Interface: A dcraw library wrapper."
HOMEPAGE="http://www.kipi-plugins.org"
SRC_URI="mirror://sourceforge/kipi/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="media-libs/jpeg
	media-libs/lcms"
RDEPEND="${DEPEND}
	!media-libs/${PN}:0
"

need-kde 3.5
