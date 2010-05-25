# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-mpd/python-mpd-0.2.1.ebuild,v 1.5 2010/05/25 20:52:39 angelos Exp $

PYTHON_DEPEND="2:2.4 3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Python MPD client library"
HOMEPAGE="http://pypi.python.org/pypi/python-mpd/"
SRC_URI="http://pypi.python.org/packages/source/p/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS="amd64 ~ppc ~ppc64 sparc x86"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="dev-util/pkgconfig"

DOCS="CHANGES.txt README.txt TODO.txt doc/commands.txt"
