# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gmpy/gmpy-1.03.ebuild,v 1.1 2008/09/12 13:18:33 sbriesen Exp $

inherit distutils

DESCRIPTION="Python bindings for dev-libs/gmp"
HOMEPAGE="http://www.aleax.it/gmpy.html"
SRC_URI="http://${PN}.googlecode.com/files/${P}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

RDEPEND="virtual/python
	dev-libs/gmp"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# HACK: distutils only support 'setup.py', so
	# we symlink what we need to 'setup.py' later
	mv setup.py setmp.py
}

src_compile() {
	local i
	for i in mp es; do
		ln -snf "set${i}.py" "setup.py" && distutils_src_compile
	done
}

src_install() {
	local i
	for i in mp es; do
		ln -snf "set${i}.py" "setup.py" && distutils_src_install
	done
	dohtml doc/index.html
	dodoc doc/gmpydoc.txt
}
