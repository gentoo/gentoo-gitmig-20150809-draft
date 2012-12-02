# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/3to2/3to2-1.0.ebuild,v 1.2 2012/12/02 19:23:54 mgorny Exp $

EAPI=4

PYTHON_COMPAT=(python2_7)
inherit distutils-r1

DESCRIPTION="Refactors valid 3.x syntax into valid 2.x syntax, if a syntactical conversion is possible"
HOMEPAGE="http://pypi.python.org/pypi/3to2"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
