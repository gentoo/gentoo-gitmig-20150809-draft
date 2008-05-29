# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/kmobiletools/kmobiletools-0.4.3.3.ebuild,v 1.7 2008/05/29 21:29:54 mrness Exp $

inherit kde

DESCRIPTION="KMobiletools is a KDE-based application that allows to control mobile phones with your PC."
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.kmobiletools.org/"
LICENSE="GPL-2"

IUSE=""
KEYWORDS="~amd64 ~ppc x86"

need-kde 3.5

src_unpack() {
	kde_src_unpack

	rm -f "${S}/configure"
}
