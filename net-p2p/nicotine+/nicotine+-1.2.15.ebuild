# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/nicotine+/nicotine+-1.2.15.ebuild,v 1.7 2010/10/15 19:16:55 ranger Exp $

EAPI="2"
PYTHON_DEPEND="2"

inherit distutils

DESCRIPTION="A fork of nicotine, a Soulseek client in Python"
HOMEPAGE="http://nicotine-plus.sourceforge.net"
SRC_URI="mirror://sourceforge/nicotine-plus/${P}.tar.bz2"

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE="geoip spell"

RDEPEND=">=dev-python/pygtk-2.12
	media-libs/mutagen
	geoip? ( >=dev-python/geoip-python-0.2.0
			 >=dev-libs/geoip-1.2.1 )
	spell? ( dev-python/sexy-python )
	!net-p2p/nicotine"

DEPEND="${RDEPEND}"

PYTHON_MODNAME="pynicotine"

pkg_setup() {
	python_set_active_version 2
}

src_install() {
	distutils_src_install
	python_convert_shebangs -r 2 "${D}"
	dosym nicotine.py /usr/bin/nicotine
}
