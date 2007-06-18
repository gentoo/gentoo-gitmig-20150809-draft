# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/kmobiletools/kmobiletools-0.5.0_beta2.ebuild,v 1.2 2007/06/18 20:15:34 philantrop Exp $

inherit kde

MY_P=${P/_beta/-beta}
DESCRIPTION="KMobiletools is a KDE-based application that allows to control mobile phones with your PC."
SRC_URI="http://download.berlios.de/kmobiletools/${MY_P}.tar.bz2"
HOMEPAGE="http://www.kmobiletools.org/"
LICENSE="GPL-2"

IUSE="kde"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="kde? ( || ( ( kde-base/libkcal kde-base/kontact ) kde-base/kdepim ) )
		>=net-wireless/kdebluetooth-1.0_beta2"

need-kde 3.4

S=${WORKDIR}/${MY_P}

src_compile() {
	myconf="$(use_enable kde libkcal)
		$(use_enable kde kontact-plugin)"

	kde_src_compile
}
