# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyxmms/pyxmms-1.06.ebuild,v 1.6 2004/09/02 17:53:27 pvdabeel Exp $

inherit distutils

DESCRIPTION="Python interface to XMMS"
HOMEPAGE="http://people.via.ecp.fr/~flo/2002/PyXMMS/xmms.html"
SRC_URI="http://people.via.ecp.fr/~flo/2002/PyXMMS/dist/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha x86 ppc"
IUSE=""

DEPEND=">=dev-lang/python-2.2.2"
RDEPEND=">=dev-lang/python-2.2.2
	>=media-sound/xmms-1.2.7-r18"

src_unpack() {
	unpack ${A}
	cd ${S}

	# fix the install prefix in setup.cfg
	cp setup.cfg setup.cfg.orig || die
	sed 's:/usr/local:/usr:' setup.cfg.orig > setup.cfg || die
}
