# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/psyco-cvs/psyco-cvs-20041130.ebuild,v 1.1 2004/12/01 00:04:59 pythonhead Exp $

inherit distutils

HOMEPAGE="http://psyco.sourceforge.net/"
DESCRIPTION="Psyco is a Python extension module which can massively speed up the execution of any Python code."
SRC_URI="mirror://gentoo/${P}.tbz2"
IUSE=""
SLOT="0"
LICENSE="MIT"
KEYWORDS="~x86"
DEPEND="!dev-python/psyco"

src_install() {
	insinto /usr/share/doc/${PF}/examples
	doins ${S}/test/*
}
