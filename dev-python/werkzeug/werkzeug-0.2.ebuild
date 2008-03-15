# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/werkzeug/werkzeug-0.2.ebuild,v 1.1 2008/03/15 21:39:35 hoffie Exp $

inherit distutils

MY_P="Werkzeug-${PV}"

DESCRIPTION="Collection of various utilities for WSGI applications"
HOMEPAGE="http://werkzeug.pocoo.org/"
SRC_URI="http://pypi.python.org/packages/source/W/Werkzeug/${MY_P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/python-2.4"
DEPEND=">=dev-python/setuptools-0.6_rc5
	${RDEPEND}"

S="${WORKDIR}/${MY_P}"
