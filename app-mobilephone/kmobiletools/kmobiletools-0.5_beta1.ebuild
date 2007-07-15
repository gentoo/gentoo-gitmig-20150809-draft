# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/kmobiletools/kmobiletools-0.5_beta1.ebuild,v 1.2 2007/07/15 02:57:21 mr_bones_ Exp $

inherit kde

DESCRIPTION="KMobiletools is a KDE-based application that allows to control mobile phones with your PC."
SRC_URI="http://download.berlios.de/kmobiletools/${P}.tar.bz2"
HOMEPAGE="http://www.kmobiletools.org/"
LICENSE="GPL-2"

IUSE="kde"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="kde? ( || ( ( kde-base/libkcal kde-base/kontact ) kde-base/kdepim ) )"

need-kde 3.3

src_compile() {
	myconf="$(use_enable kde libkcal)
		$(use_enable kde kontact-plugin)"

	kde_src_compile
}
