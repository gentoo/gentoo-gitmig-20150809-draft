# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/4suite/4suite-1.0_alpha3.ebuild,v 1.9 2005/01/20 03:56:58 pythonhead Exp $

inherit distutils

MY_P=${P/_alpha/a}
MY_P=${MY_P/4s/4S}
S=${WORKDIR}/4Suite
DESCRIPTION="Python tools for XML processing and object-databases."
SRC_URI="mirror://sourceforge/foursuite/${MY_P}.tar.gz"
HOMEPAGE="http://www.4suite.org/"

DEPEND=">=dev-python/pyxml-0.6.5"

IUSE=""
SLOT="0"
KEYWORDS="x86 sparc alpha ~ppc"
LICENSE="Apache-1.1"

PYTHON_MODNAME="Ft"
DOCS="docs/*.txt"

