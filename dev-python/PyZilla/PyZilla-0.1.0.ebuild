# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyZilla/PyZilla-0.1.0.ebuild,v 1.1 2011/03/26 05:52:10 vapier Exp $

inherit distutils

DESCRIPTION="Python wrapper for the BugZilla XML-RPC API"
HOMEPAGE="http://pypi.python.org/pypi/PyZilla"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DOCS="CHANGES.txt"
