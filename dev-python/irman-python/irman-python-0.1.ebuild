# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/irman-python/irman-python-0.1.ebuild,v 1.10 2003/06/22 12:15:59 liquidx Exp $

inherit distutils

IUSE=""
DESCRIPTION="A minimal set of Python bindings for libirman."
SRC_URI="http://bluweb.com/chouser/proj/${PN}/${P}.tar.gz"
HOMEPAGE="http://bluweb.com/chouser/proj/irman-python/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc alpha"

DEPEND="media-libs/libirman"

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}
	doins test_name.py
}
