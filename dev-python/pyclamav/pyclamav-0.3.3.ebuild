# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyclamav/pyclamav-0.3.3.ebuild,v 1.1 2006/05/20 22:15:34 lucass Exp $

inherit distutils

DESCRIPTION="Python binding for libclamav"
HOMEPAGE="http://xael.org/norman/python/pyclamav/"
SRC_URI="http://xael.org/norman/python/pyclamav/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
DEPEND=">=dev-lang/python-2.2
	>=app-antivirus/clamav-0.80"
SLOT="0"
IUSE=""

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF} && doins example.py
}
