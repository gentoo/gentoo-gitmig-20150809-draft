# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/scons/scons-0.94-r1.ebuild,v 1.1 2003/12/16 20:35:36 lanius Exp $

inherit distutils

DESCRIPTION="Extensible python-based build utility"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"
HOMEPAGE="http://www.scons.org"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc ~sparc ~alpha ~hppa ~mips ~arm ~amd64 ~ia64"

DEPEND=">=dev-lang/python-2.0"

DOCS="RELEASE.txt CHANGES.txt LICENSE.txt"

src_install () {
	distutils_src_install
	doman scons.1 sconsign.1
}
