# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycrypto/pycrypto-2.0-r1.ebuild,v 1.1 2005/01/25 01:54:54 lucass Exp $

inherit distutils

DESCRIPTION="Python Cryptography Toolkit"
HOMEPAGE="http://www.amk.ca/python/code/crypto.html"
SRC_URI="http://www.amk.ca/files/python/crypto/${P}.tar.gz"
KEYWORDS="~x86 ~alpha ~sparc ~amd64 ~ppc"
LICENSE="freedist"
DEPEND="dev-libs/gmp
	virtual/python"
SLOT="0"
IUSE=""
DOCS="ACKS ChangeLog LICENSE MANIFEST PKG-INFO README TODO Doc/pycrypt.tex"
