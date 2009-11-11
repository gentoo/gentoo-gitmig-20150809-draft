# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/kconvert/kconvert-1.1-r1.ebuild,v 1.6 2009/11/11 11:42:14 ssuominen Exp $

ARTS_REQUIRED=never
inherit kde

DESCRIPTION="KDE tool to convert between different units"
HOMEPAGE="http://apps.kde.com/na/2/counter/vid/5632/kcurl"
SRC_URI="http://ftp.kde.com/Math_Science/KConvert/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE=""

need-kde 3.5

S=${WORKDIR}/${PN}

src_unpack() {
	kde_src_unpack
	epatch "${FILESDIR}"/${P}-arts-configure.patch
}
