# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/tailor/tailor-0.9.29-r1.ebuild,v 1.1 2007/10/28 21:04:23 hawking Exp $

NEED_PYTHON=2.4

inherit eutils distutils

DESCRIPTION="A tool to migrate changesets between version control systems."
HOMEPAGE="http://wiki.darcs.net/index.html/Tailor"
SRC_URI="http://darcs.arstecnica.it/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

PYTHON_MODNAME="vcpx"

src_unpack() {
	distutils_src_unpack

	epatch "${FILESDIR}/${P}-compare_trees.patch"
}
