# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/liquid-weather/liquid-weather-6.2.ebuild,v 1.1 2005/06/26 19:53:00 smithj Exp $

# stupid naming conventions...
S="${WORKDIR}/liquid_weather_plus"
MY_PN="lwp"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="a superkaramba plugin for displaying weather information"
HOMEPAGE="http://homepages.comnet.co.nz/~matt-sarah/index.html"
SRC_URI="http://www.message.co.nz/~matt-sarah/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/x11
	>=x11-misc/superkaramba-0.36"


src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}



src_install() {
	make DESTDIR=${D} install

#	dodoc

	einfo "you may want to obtain more iconsets at the following location:"
	einfo "http://homepages.comnet.co.nz/~matt-sarah/computer_hardware_news.html"
}
