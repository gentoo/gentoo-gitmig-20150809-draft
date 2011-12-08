# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/llfuse/llfuse-0.37.ebuild,v 1.1 2011/12/08 01:23:44 radhermit Exp $

EAPI="4"
PYTHON_DEPEND="*"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Python bindings for the low-level FUSE API"
HOMEPAGE="http://python-llfuse.googlecode.com/ http://pypi.python.org/pypi/llfuse"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=">=sys-fs/fuse-2.8.0"
DEPEND="${RDEPEND}
	dev-python/setuptools
	dev-util/pkgconfig"

src_install() {
	distutils_src_install
	use doc && dohtml -r doc/html/*
}
