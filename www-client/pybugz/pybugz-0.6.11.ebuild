# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/pybugz/pybugz-0.6.11.ebuild,v 1.1 2006/09/02 12:43:53 liquidx Exp $

inherit distutils

DESCRIPTION="Command line interface to (Gentoo) Bugzilla"
HOMEPAGE="http://www.liquidx.net/pybugz/"
SRC_URI="http://media.liquidx.net/static/pybugz/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE=""
DEPEND=">=dev-lang/python-2.4
	dev-python/elementtree"

