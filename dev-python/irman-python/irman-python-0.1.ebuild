# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/irman-python/irman-python-0.1.ebuild,v 1.14 2005/08/26 03:30:47 agriffis Exp $

inherit distutils

IUSE=""
DESCRIPTION="A minimal set of Python bindings for libirman."
SRC_URI="http://bluweb.com/chouser/proj/${PN}/${P}.tar.gz"
HOMEPAGE="http://bluweb.com/chouser/proj/irman-python/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~ia64 sparc x86"

DEPEND="media-libs/libirman"

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}
	doins test_name.py
}
