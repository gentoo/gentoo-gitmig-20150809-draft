# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/psyco/psyco-1.4.ebuild,v 1.3 2007/06/25 18:01:39 hawking Exp $

inherit distutils

HOMEPAGE="http://psyco.sourceforge.net/"
DESCRIPTION="Python extension module which can massively speed up the execution of any Python code."
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.gz"

IUSE=""
SLOT="0"
LICENSE="MIT"
KEYWORDS="x86"
DEPEND=">=dev-lang/python-2.1"

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}/examples
	doins ${S}/test/*
}
