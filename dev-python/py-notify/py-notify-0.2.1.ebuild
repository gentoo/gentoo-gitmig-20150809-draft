# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/py-notify/py-notify-0.2.1.ebuild,v 1.1 2010/08/20 09:37:43 hwoarang Exp $

EAPI=2

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit python distutils

DESCRIPTION="Tools for implementing the Observer programming pattern in Python"
HOMEPAGE="http://home.gna.org/py-notify"
SRC_URI="http://download.gna.org/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
