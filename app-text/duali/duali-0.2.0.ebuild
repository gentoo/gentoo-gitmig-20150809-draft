# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/duali/duali-0.2.0.ebuild,v 1.1 2007/01/22 20:04:01 antarus Exp $

inherit distutils

IUSE=""

DESCRIPTION="Arabic dictionary based on the DICT protocol"
HOMEPAGE="http://www.arabeyes.org/project.php?proj=Duali"
SRC_URI="mirror://sourceforge/arabeyes/${P}.tar.bz2"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~amd64 ~ia64 ~ppc ~sparc ~alpha ~hppa ~mips"

DEPEND="dev-lang/python"
PDEPEND="app-dicts/duali-data"

src_install() {
	into /usr
	dobin duali dict2db trans2arabic arabic2trans
	insinto /etc
	doins duali.conf
	doman doc/man/*

	distutils_python_version
	insinto /usr/lib/python${PYVER}/site-packages/pyduali
	doins pyduali/*.py

	dodoc README ChangeLog INSTALL MANIFEST
}
