# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/paramiko/paramiko-0.9h.ebuild,v 1.3 2004/11/04 16:43:34 pythonhead Exp $

inherit distutils

MY_PV="0.9-horsea"
DESCRIPTION="SSH2 implementation for Python"
HOMEPAGE="http://www.lag.net/~robey/paramiko"
SRC_URI="http://www.lag.net/~robey/paramiko/${PN}-${MY_PV}.zip"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""
DEPEND="virtual/python
	>=dev-python/pycrypto-1.9_alpha6
	app-arch/unzip"
S="${WORKDIR}/${PN}-${MY_PV}"

src_install() {
	distutils_src_install
	dohtml -r docs/*
}
