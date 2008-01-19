# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pymsn/pymsn-0.3.1.ebuild,v 1.2 2008/01/19 12:05:53 coldwind Exp $

inherit distutils

DESCRIPTION="The library behind the msn connection manager: telepathy-butterfly"
HOMEPAGE="http://telepathy.freedesktop.org/wiki/Pymsn"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	>=dev-lang/python-2.4
	|| (
		>=dev-lang/python-2.5
		dev-python/elementtree
		dev-python/celementtree
		)
	>=dev-python/pygtk-2.10.0
	>=dev-python/pyopenssl-0.6
	dev-python/pycrypto
	>=dev-python/adns-python-1.2.1"
RDEPEND="${DEPEND}"

DOCS="AUTHORS NEWS README"
