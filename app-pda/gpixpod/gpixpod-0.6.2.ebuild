# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/gpixpod/gpixpod-0.6.2.ebuild,v 1.1 2006/12/21 03:42:49 tester Exp $

inherit distutils

DESCRIPTION="Organize photos on your iPod, freely!"
HOMEPAGE="http://www.gpixpod.org/"
SRC_URI="mirror://sourceforge/gpixpod/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-python/pygtk-2.8.4
		>=x11-libs/gtk+-2.0.0"
RDEPEND="${DEPEND}"

src_unpack() {
	distutils_python_version
	unpack ${A}

	# Fixing gpixpod.py for searching gpixpod.glade in the same directory
	sed -i "s:gpixpod\.glade:/usr/share/gpixpod/gpixpod\.glade:g" ${S}/gpixpod.py

	# Fixing launching script
	sed -i "s:/usr/lib/gpixpod/:/usr/$(get_libdir)/python${PYVER}/site-packages/:" ${S}/gpixpod
}

src_install() {
	distutils_src_install

	mv ${D}/usr/lib/gpixpod/* ${D}/usr/share/gpixpod
	rmdir {D}/usr/lib/gpixpod
}
