# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyxmms/pyxmms-2.02.ebuild,v 1.9 2004/10/19 17:43:26 kloeri Exp $

inherit distutils

DESCRIPTION="Python interface to XMMS"
HOMEPAGE="http://people.via.ecp.fr/~flo/2002/PyXMMS/xmms.html"
SRC_URI="http://people.via.ecp.fr/~flo/2002/PyXMMS/dist/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ppc amd64 alpha"
IUSE=""

RDEPEND=">=dev-lang/python-2.2.2
	>=media-sound/xmms-1.2.7-r18"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

PYTHON_MODNAME="xmms"

src_unpack() {
	unpack ${A}
	# fix the install prefix in setup.cfg
	sed -e 's:/usr/local:/usr:' -i ${S}/setup.cfg || die "patching setup.cfg failed"
}
