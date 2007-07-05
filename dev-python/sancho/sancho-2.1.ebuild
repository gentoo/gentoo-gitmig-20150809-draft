# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sancho/sancho-2.1.ebuild,v 1.6 2007/07/05 11:05:34 hawking Exp $

inherit distutils

MY_P=${P/s/S}
DESCRIPTION="Sancho is a unit testing framework"
HOMEPAGE="http://www.mems-exchange.org/software/sancho/"
SRC_URI="http://www.mems-exchange.org/software/${PN}/${MY_P}.tar.gz"

LICENSE="CNRI"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.2"

S=${WORKDIR}/${MY_P}

src_install() {
	DOCS="CHANGES.txt"
	distutils_src_install
}
