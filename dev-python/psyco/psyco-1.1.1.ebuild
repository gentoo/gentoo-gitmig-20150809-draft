# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/psyco/psyco-1.1.1.ebuild,v 1.3 2004/01/16 11:10:28 liquidx Exp $

inherit distutils

HOMEPAGE="http://psyco.sourceforge.net/"
DESCRIPTION="Psyco is a Python extension module which can massively speed up the execution of any Python code."
SRC_URI="mirror://sourceforge/psyco/${P}-src.tar.gz"

IUSE=""
SLOT="0"
LICENSE="MIT"
KEYWORDS="x86"

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}/examples
	doins ${S}/test/*
}
