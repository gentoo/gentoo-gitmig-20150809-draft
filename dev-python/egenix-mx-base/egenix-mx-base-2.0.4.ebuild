# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/egenix-mx-base/egenix-mx-base-2.0.4.ebuild,v 1.9 2003/07/20 00:34:22 tester Exp $

inherit distutils flag-o-matic

IUSE=""
DESCRIPTION="egenix utils for Python."
SRC_URI="http://www.lemburg.com/files/python/${P}.tar.gz"
HOMEPAGE="http://www.egenix.com/"

DEPEND="virtual/python"
SLOT="0"
KEYWORDS="x86 ~sparc ~alpha ~ppc amd64"
LICENSE="eGenixPublic"
#please note, there is also a possibility to buy a commercial license
#from egenix.com
src_compile() {
	replace-flags "-O[3s]" "-O2"
	distutils_src_compile
}	

src_install() {
	distutils_src_install
	dohtml -a html -r mx
}
