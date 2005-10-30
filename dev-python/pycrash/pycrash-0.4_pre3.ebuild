# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycrash/pycrash-0.4_pre3.ebuild,v 1.3 2005/10/30 01:58:46 weeve Exp $

inherit distutils


MY_P="PyCrash-${PV/_/-}"
DESCRIPTION="PyCrash: a Run-Time Exception Dumper for Python programs"
HOMEPAGE="http://www.pycrash.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
DOCS="NEWS TODO THANKS"
DEPEND=">=virtual/python-2.3"
S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	sed -i -e 's/pre2/pre3/' ${S}/pycrash/pycrash.py
}
