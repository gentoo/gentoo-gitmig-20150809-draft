# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/fonttools/fonttools-2.0_beta1.ebuild,v 1.1 2004/07/10 08:55:14 usata Exp $

inherit distutils

MY_P=${P/_beta/b}
DESCRIPTION="Multi-producer-multi-consumer signal dispatching mechanism for Python"
HOMEPAGE="http://fonttools.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/python
	dev-python/numeric
	dev-python/pyxml"

S="${WORKDIR}/${PN}"

DOCS="README.txt Doc/*.txt"
