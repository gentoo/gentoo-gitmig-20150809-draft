# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/kmobiletools/kmobiletools-0.4.3.3.ebuild,v 1.1 2006/04/22 13:36:16 flameeyes Exp $

inherit kde

DESCRIPTION="KMobiletools is a KDE-based application that allows to control mobile phones with your PC."
SRC_URI="http://download.berlios.de/kmobiletools/kmobiletools-${PV}.tar.bz2"
HOMEPAGE="http://kmobiletools.berlios.de/"
LICENSE="GPL-2"

IUSE=""
KEYWORDS="~amd64 ~ppc ~x86"

need-kde 3.2

src_unpack() {
	kde_src_unpack

	rm -f "${S}/configure"
}

src_install() {
	kde_src_install

	dodir /usr/share/applications/kde
	# Move the .desktop file in FDO's defined directory
	mv ${D}/usr/share/applnk/Utilities/kmobiletools.desktop \
		${D}/usr/share/applications/kde
}

