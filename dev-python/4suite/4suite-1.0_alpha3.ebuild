# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/4suite/4suite-1.0_alpha3.ebuild,v 1.3 2004/03/23 09:51:42 liquidx Exp $

inherit distutils

MY_P=${P/4s/4S}
MY_P=${MY_P/_alpha/a}
S=${WORKDIR}/4Suite
DESCRIPTION="Python tools for XML processing and object-databases."
SRC_URI="ftp://ftp.4suite.org/pub/4Suite/${MY_P}.tar.gz"
HOMEPAGE="http://www.4suite.org/"

DEPEND=">=dev-python/pyxml-0.6.5"

SLOT="0"
KEYWORDS="x86 sparc ~alpha ~ppc"
LICENSE="Apache-1.1"

PYTHON_MODNAME="Ft"
DOCS="docs/*.txt"

