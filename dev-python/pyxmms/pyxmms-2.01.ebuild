# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyxmms/pyxmms-2.01.ebuild,v 1.2 2003/11/20 20:13:46 dholm Exp $

inherit distutils

DESCRIPTION="Python interface to XMMS"
HOMEPAGE="http://www.via.ecp.fr/~flo/2002/PyXMMS/xmms.html"
SRC_URI="http://www.via.ecp.fr/~flo/2002/PyXMMS/dist/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"
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
