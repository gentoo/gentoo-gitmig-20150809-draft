# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/nicotine/nicotine-1.0.6.ebuild,v 1.2 2003/12/20 10:14:36 dholm Exp $

inherit distutils

DESCRIPTION="Soulseek client written in Python"
HOMEPAGE="http://thegraveyard.org/nicotine/"

SRC_URI="http://thegraveyard.org/nicotine/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE="oggvorbis geoip"

DEPEND="virtual/python
	>=dev-python/pygtk-1.99.16
	oggvorbis? ( >=dev-python/pyvorbis-1
				>=dev-python/pyogg-1 )
	geoip? ( >=dev-python/geoip-python-0.2.0
		>=dev-libs/geoip-1.2.1 )"
