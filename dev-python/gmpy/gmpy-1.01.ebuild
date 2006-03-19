# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gmpy/gmpy-1.01.ebuild,v 1.2 2006/03/19 22:50:13 halcy0n Exp $

inherit distutils

MY_PV=${PV//.}

DESCRIPTION="Python bindings for dev-libs/gmp"
HOMEPAGE="http://gmpy.sourceforge.net/"
SRC_URI="mirror://sourceforge/gmpy/${PN}-sources-${MY_PV}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

S="${WORKDIR}/${PN}"

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
