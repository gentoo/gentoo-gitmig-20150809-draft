# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/kmobiletools/kmobiletools-0.5.0_beta3.ebuild,v 1.1 2007/06/18 20:15:34 philantrop Exp $

inherit kde eutils

MY_P=${P/_beta/-beta}
DESCRIPTION="KMobiletools is a KDE-based application that allows to control mobile phones with your PC."
SRC_URI="http://download.berlios.de/kmobiletools/${MY_P}.tar.bz2"
HOMEPAGE="http://www.kmobiletools.org/"
LICENSE="GPL-2"

IUSE="bluetooth gammu kde obex"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="kde? ( || ( ( kde-base/libkcal kde-base/kontact ) kde-base/kdepim ) )
		bluetooth? ( >=net-wireless/kdebluetooth-1.0_beta2 )
		gammu? ( >=app-mobilephone/gammu-1.10.6 )
		obex? ( >=app-mobilephone/obexftp-0.21 )"

need-kde 3.4

S=${WORKDIR}/${MY_P}

src_unpack() {
	kde_src_unpack

	epatch ${FILESDIR}/${P}-no-automagic-deps.patch
	# remove configure script to trigger it's rebuild during kde_src_compile
	rm -f ${S}/configure
}

src_compile() {
	myconf="$(use_enable kde libkcal)
		$(use_enable kde kontact)
		$(use_with gammu)
		$(use_enable bluetooth kdebluetooth)
		$(use_enable obex obexftp)
		--disable-p2kmoto"
	# the last 3 configure switches have only effect when above automagic deps patch is applied

	kde_src_compile
}

pkg_postinst() {
	if use gammu ; then
		echo
		elog "You have enabled gammu engine backend. Please note that support for this"
		elog "engine in ${PN} is considered experimental and may not work as expected."
		elog "More information and configuration steps for gammu engine can be found here:"
		elog "http://www.kmobiletools.org/gammu"
		echo
	fi
}
