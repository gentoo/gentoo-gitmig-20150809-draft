# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cryptlib_py/cryptlib_py-3.2.2.ebuild,v 1.1 2005/11/02 03:46:57 sbriesen Exp $

inherit distutils

MY_PV=${PV//.}

DESCRIPTION="Python bindings for dev-libs/cryptlib"
HOMEPAGE="http://www.cs.auckland.ac.nz/~pgut001/cryptlib/"
SRC_URI="ftp://ftp.franken.de/pub/crypt/cryptlib/cl${MY_PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

S="${WORKDIR}/bindings"

DEPEND="virtual/python
	>=dev-libs/cryptlib-${PV}"

src_install(){
	DOCS="../README"
	distutils_src_install
}
