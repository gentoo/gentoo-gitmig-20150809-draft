# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyflakes/pyflakes-0.3.0.ebuild,v 1.1 2009/01/31 23:40:50 patrick Exp $

NEED_PYTHON=2.3

inherit distutils

DESCRIPTION="Passive checker for python programs."
HOMEPAGE="http://divmod.org/trac/wiki/DivmodPyflakes"
SRC_URI="http://pypi.python.org/packages/source/p/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""
