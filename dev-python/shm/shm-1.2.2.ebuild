# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/shm/shm-1.2.2.ebuild,v 1.3 2008/10/25 20:58:04 pvdabeel Exp $

NEED_PYTHON=2.3

inherit distutils

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

DESCRIPTION="Python modules to access System V shared memory and semaphores."
HOMEPAGE="http://nikitathespider.com/python/${PN}/"
SRC_URI="http://nikitathespider.com/python/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

src_install() {
	distutils_src_install

	dohtml ReadMe.html
	insinto /usr/share/doc/${PF}
	doins -r demo
}
