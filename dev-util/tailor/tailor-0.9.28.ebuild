# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/tailor/tailor-0.9.28.ebuild,v 1.1 2007/06/18 15:30:01 dev-zero Exp $

NEED_PYTHON=2.4

inherit distutils

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
