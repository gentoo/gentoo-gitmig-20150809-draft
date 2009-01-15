# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycxx/pycxx-5.4.2.ebuild,v 1.1 2009/01/15 09:13:33 bicatali Exp $

EAPI=2
inherit eutils distutils

DESCRIPTION="Set of facilities to extend Python with C++"
HOMEPAGE="http://cxx.sourceforge.net"
SRC_URI="mirror://sourceforge/cxx/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

PYTHON_MODNAME="CXX"

src_prepare() {
	epatch "${FILESDIR}"/${P}-headers-c.patch
}

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}
	doins Doc/PyCXX.html
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins Demo/* || die
	fi
}
