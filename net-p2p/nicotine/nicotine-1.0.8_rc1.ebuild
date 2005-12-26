# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/nicotine/nicotine-1.0.8_rc1.ebuild,v 1.4 2005/12/26 17:30:04 lu_zero Exp $

inherit distutils

DESCRIPTION="Soulseek client written in Python"
HOMEPAGE="http://thegraveyard.org/nicotine/"

SRC_URI="http://nicotine.thegraveyard.org/${PN}-1.0.8rc1.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~amd64"
IUSE="vorbis geoip"
S="${WORKDIR}/${PN}-1.0.8rc1"
DEPEND="virtual/python
	>=dev-python/pygtk-1.99.16
	vorbis? ( >=dev-python/pyvorbis-1
				>=dev-python/pyogg-1 )
	geoip? ( >=dev-python/geoip-python-0.2.0
		>=dev-libs/geoip-1.2.1 )"


