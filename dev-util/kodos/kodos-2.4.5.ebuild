# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kodos/kodos-2.4.5.ebuild,v 1.2 2004/11/23 19:19:34 carlo Exp $

inherit distutils

DESCRIPTION="Kodos is a Python GUI utility for creating, testing and debugging regular expressions."
HOMEPAGE="http://kodos.sourceforge.net/"
SRC_URI="mirror://sourceforge/kodos/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc"
IUSE=""

DEPEND=">dev-python/PyQt-3.8.1"

src_install() {
	distutils_src_install
	cd ${D}/usr/bin
	dosym kodos.py /usr/bin/kodos
}
