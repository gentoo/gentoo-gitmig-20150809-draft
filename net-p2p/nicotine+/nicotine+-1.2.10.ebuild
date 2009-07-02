# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/nicotine+/nicotine+-1.2.10.ebuild,v 1.3 2009/07/02 10:03:38 fauli Exp $

inherit distutils multilib toolchain-funcs

DESCRIPTION="A fork of nicotine, a Soulseek client in Python"
HOMEPAGE="http://nicotine-plus.sourceforge.net"
SRC_URI="http://www.nicotine-plus.org/files/${P}.tar.bz2"

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86 ~x86-fbsd"
IUSE="geoip spell vorbis"

RDEPEND="virtual/python
	>=dev-python/pygtk-2.10
	vorbis? ( >=dev-python/pyvorbis-1.4-r3
			  >=dev-python/pyogg-1 )
	geoip? ( >=dev-python/geoip-python-0.2.0
			 >=dev-libs/geoip-1.2.1 )
	spell? ( dev-python/sexy-python )
	!net-p2p/nicotine"

DEPEND="${RDEPEND}"

src_install() {
	distutils_python_version
	distutils_src_install \
		--install-lib /usr/$(get_libdir)/python${PYVER}/site-packages
}
