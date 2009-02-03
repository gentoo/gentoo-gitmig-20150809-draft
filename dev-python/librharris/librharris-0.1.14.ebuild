# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/librharris/librharris-0.1.14.ebuild,v 1.1 2009/02/03 20:07:22 patrick Exp $

inherit distutils

SLOT="0"

MY_P="${P/lib/lib_}"
DESCRIPTION="A Python library for pulling, parsing \
and pickling remote web page data and related net-aware tasks."
HOMEPAGE="http://www.python.org/pypi/lib_rharris"
SRC_URI="http://pypi.python.org/packages/source/l/${PN/lib/lib_}/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="virtual/python"

src_install() {
	distutils_src_install
}
