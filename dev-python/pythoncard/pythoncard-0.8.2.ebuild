# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pythoncard/pythoncard-0.8.2.ebuild,v 1.2 2007/07/04 21:19:23 hawking Exp $

inherit distutils

MY_P=PythonCard-${PV}

DESCRIPTION="Cross-platform GUI construction kit for python"
HOMEPAGE="http://pythoncard.sourceforge.net/index.html"
SRC_URI="mirror://sourceforge/pythoncard/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-python/wxpython-2.6"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_install() {
	distutils_src_install
	dohtml -r docs/html/*
	dodoc docs/*.txt
}
