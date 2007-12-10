# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/nicotine/nicotine-1.0.8.ebuild,v 1.10 2007/12/10 07:25:47 betelgeuse Exp $

inherit distutils

DESCRIPTION="Soulseek client written in Python"
HOMEPAGE="http://thegraveyard.org/nicotine/"

SRC_URI="http://nicotine.thegraveyard.org/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86 ~x86-fbsd"
IUSE="vorbis geoip"

DEPEND="virtual/python
	>=dev-python/pygtk-1.99.16
	vorbis? ( >=dev-python/pyvorbis-1.4-r1
			  >=dev-python/pyogg-1 )
	geoip? ( >=dev-python/geoip-python-0.2.0
			 >=dev-libs/geoip-1.2.1 )
	!net-p2p/nicotine+"

src_install() {

	distutils_src_install

	doicon "${FILESDIR}/nicotine-n.png"

	make_desktop_entry nicotine Nicotine nicotine-n
}
