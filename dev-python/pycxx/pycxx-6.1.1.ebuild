# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycxx/pycxx-6.1.1.ebuild,v 1.3 2009/12/09 18:46:56 nixnut Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit eutils distutils

DESCRIPTION="Set of facilities to extend Python with C++"
HOMEPAGE="http://cxx.sourceforge.net"
SRC_URI="mirror://sourceforge/cxx/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos"
IUSE="doc examples"

PYTHON_MODNAME="CXX"

src_prepare() {
	epatch "${FILESDIR}/${PN}-6.1.0-setup.py.patch"
	epatch "${FILESDIR}/${PN}-6.1.0-python-3.patch"
	epatch "${FILESDIR}/${PN}-6.1.0-C_compatible_headers.patch"

	sed -e "/^#include/s:/Python[23]/:/:" -i CXX/*/*.hxx || die "sed failed"
}

src_install() {
	distutils_src_install
	if use doc; then
		dohtml -r Doc/ || die "dohtml failed"
	fi

	if use examples; then
		docinto examples/python-2
		dodoc Demo/Python2/* || die "dodoc failed"
		docinto examples/python-3
		dodoc Demo/Python3/* || die "dodoc failed"
	fi
}
