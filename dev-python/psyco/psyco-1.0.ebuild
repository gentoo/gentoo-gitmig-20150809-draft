# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/psyco/psyco-1.0.ebuild,v 1.6 2004/12/01 00:22:26 pythonhead Exp $

inherit distutils

HOMEPAGE="http://psyco.sourceforge.net/"
DESCRIPTION="Psyco is a Python extension module which can massively speed up the execution of any Python code."
SRC_URI="mirror://sourceforge/psyco/${P}-src.tar.gz"

IUSE=""
SLOT="0"
LICENSE="MIT"
KEYWORDS="x86"
DEPEND="<dev-lang/python-2.4
	!dev-python/psyco-cvs"

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}/examples
	doins ${S}/test/*
}
