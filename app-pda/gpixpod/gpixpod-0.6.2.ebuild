# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/gpixpod/gpixpod-0.6.2.ebuild,v 1.4 2008/05/05 03:15:04 tester Exp $

inherit distutils

DESCRIPTION="Organize photos on your iPod, freely!"
HOMEPAGE="http://www.gpixpod.org/"
SRC_URI="mirror://sourceforge/gpixpod/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/pygtk-2.8.4
		>=x11-libs/gtk+-2.0.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	distutils_python_version
	unpack ${A}
	cd ${S}

	# Fixing gpixpod.py for searching gpixpod.glade in the same directory
	sed -i -e "s:gpixpod\.glade:/usr/share/gpixpod/gpixpod\.glade:g" /gpixpod.py

	# Fixing launching script and Makefile
	sed -i -e s:python2.4:python${PYVER}:g Makefile gpixpod
}

src_install() {
	distutils_src_install

	mv ${D}/usr/lib/gpixpod/* ${D}/usr/share/gpixpod
	rmdir {D}/usr/lib/gpixpod

	rm -rf ${D}/usr/share/doc/gpixpod
	dodoc KNOWNBUGS
}
