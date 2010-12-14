# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-mpd/python-mpd-0.3.0.ebuild,v 1.1 2010/12/14 21:52:55 angelos Exp $

EAPI="3"
PYTHON_DEPEND="2:2.4 3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Python MPD client library"
HOMEPAGE="http://pypi.python.org/pypi/python-mpd/"
SRC_URI="mirror://pypi/p/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="dev-util/pkgconfig"

DOCS="CHANGES.txt README.txt doc/commands.txt"
