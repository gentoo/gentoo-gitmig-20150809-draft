# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cryptlib_py/cryptlib_py-3.3.2.ebuild,v 1.1 2009/01/31 00:21:25 dragonheart Exp $

inherit distutils

MY_PV=${PV//.}

DESCRIPTION="Python bindings for dev-libs/cryptlib"
HOMEPAGE="http://www.cs.auckland.ac.nz/~pgut001/cryptlib/"
SRC_URI="ftp://ftp.franken.de/pub/crypt/cryptlib/cl${MY_PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/bindings"

RDEPEND="virtual/python
	>=dev-libs/cryptlib-${PV}"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_unpack() {
	unzip -qoa "${DISTDIR}/cl${MY_PV}.zip"
}

src_install(){
	DOCS="../README"
	distutils_src_install
}
