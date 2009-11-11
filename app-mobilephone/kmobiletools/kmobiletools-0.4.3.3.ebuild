# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/kmobiletools/kmobiletools-0.4.3.3.ebuild,v 1.8 2009/11/11 12:03:07 ssuominen Exp $

ARTS_REQUIRED=never
inherit kde

DESCRIPTION="KMobiletools is a KDE-based application that allows to control mobile phones with your PC."
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.kmobiletools.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

need-kde 3.5

src_unpack() {
	kde_src_unpack
	rm -f "${S}/configure"
}
