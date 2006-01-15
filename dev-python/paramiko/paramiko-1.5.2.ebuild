# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/paramiko/paramiko-1.5.2.ebuild,v 1.2 2006/01/15 00:23:30 flameeyes Exp $

inherit distutils

DESCRIPTION="SSH2 implementation for Python"
HOMEPAGE="http://www.lag.net/paramiko/"
SRC_URI="http://www.lag.net/paramiko/download/${P}.zip"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND="virtual/python
	>=dev-python/pycrypto-1.9_alpha6
	app-arch/unzip"

src_install() {
	distutils_src_install
	dohtml -r docs/*
	insinto /usr/share/doc/${PF}/examples
	doins demo*.py forward.py
}

src_test() {
	"${python}" test.py || die "tests failed"
}
